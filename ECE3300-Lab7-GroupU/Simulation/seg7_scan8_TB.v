`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles 
// 
// Create Date: 07/30/2026 05:49:43 PM
// Design Name: seven seg testbench
// Module Name: seg7_scan8_tb
// Project Name: ECE 3300 Group U Lab 7
// Target Devices: Nexys a7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seg7_scan8_TB(

                   );
           
    reg clk_tb;
    reg rst_n_tb;
    
    reg [15:0] word_tb;
    
    wire [7:0] an_tb;
    wire [6:0] seg_tb;
    
    reg [7:0] expected_an;
    reg [6:0] expected_seg;
    
    integer i;
    integer tasksfailed;
    
    seg7_scan8 scan_tb(
                        .clk_1kHz(clk_tb),
                        .rst_n(rst_n_tb),
                        .word(word_tb),
                        .an(an_tb),
                        .seg(seg_tb)
                     );    
                          
    initial
    begin
        clk_tb = 1'b0;
        rst_n_tb = 1'b0; 
        
        word_tb = 16'hDCBA;  
         
        tasksfailed = 0;
    end

    always
    begin
        #5 clk_tb = ~clk_tb;
    end 
    
    initial
    begin
        @(posedge clk_tb);
        #1;
        rst_n_tb = 1'b1;
        
        for(i = 0; i < 8; i = i + 1) begin
            case(i)
                0: begin
                    expected_an = 8'b11111110;
                    expected_seg = 7'b0001000;
                end
                
                1: begin
                    expected_an = 8'b11111101;
                    expected_seg = 7'b1100000;
                end
                
                2: begin
                    expected_an = 8'b11111011;
                    expected_seg = 7'b0110001;
                end
                
                3: begin
                    expected_an = 8'b11110111;
                    expected_seg = 7'b1000010;
                end
                
                default: begin
                    expected_an = 8'b11111111;
                    expected_seg = 7'b1111111;
                end
            endcase
            
            if((an_tb !== expected_an) || (seg_tb !== expected_seg))
            begin
                tasksfailed = tasksfailed + 1;
                $display("FAILED: Digit = %d:    AN = %b, expected = %b    SEG = %b, expected = %b", i, an_tb, expected_an, seg_tb, expected_seg);
            end
            
            if(i < 7) begin
                @(posedge clk_tb)
                #1;
            end
        end
        
        if(tasksfailed == 0)
            $display("All tests passed");
        else
            $display("%d tests failed", tasksfailed);
            
        $finish;
    end
endmodule
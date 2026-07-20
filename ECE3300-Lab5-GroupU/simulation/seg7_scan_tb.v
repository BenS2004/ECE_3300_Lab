`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson & Ben Robles
// 
// Create Date: 07/16/2026 06:34:27 PM
// Design Name: 7seg scanning testbench
// Module Name: seg7_scan_tb
// Project Name: ECE3300 Lab 5 Group U
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


module seg7_scan_tb(

                   );
           
    reg clk_tb;
    reg rst_n_tb;
    reg [7:0] BCD_tb;
    
    wire [7:0] AN_tb;
    wire [6:0] SEG_tb;
    
    integer i;
    integer tasksfailed;
    integer tempfail;
    
    reg [6:0] displaycheck;
    
    seg7_scan scan_tb(
                        .clk(clk_tb),
                        .rst_n(rst_n_tb),
                        .BCD(BCD_tb),
                        .AN(AN_tb),
                        .SEG(SEG_tb)
                     );    
                          
    initial
    begin
        clk_tb = 1'b0;
        rst_n_tb = 1'b0;
        BCD_tb = 8'h00;
        
        tasksfailed = 0;
        tempfail = 0;
        displaycheck = 7'b1111111;
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
        
        for(i = 0; i < 10; i = i + 1)
        begin
            BCD_tb = {i[3:0], i[3:0]};
            
            tempfail = tasksfailed;
            
            case(i)
                    0: displaycheck = 7'b0000001;
                    1: displaycheck = 7'b1001111;
                    2: displaycheck = 7'b0010010;
                    3: displaycheck = 7'b0000110;
                    4: displaycheck = 7'b1001100;
                    5: displaycheck = 7'b0100100;
                    6: displaycheck = 7'b0100000;
                    7: displaycheck = 7'b0001111;
                    8: displaycheck = 7'b0000000;
                    9: displaycheck = 7'b0001100;
                    default: displaycheck = 7'b1111111;
            endcase
                    
            #40;
            
            if(displaycheck !== SEG_tb)
            begin
                tasksfailed = tasksfailed + 1;
            end

            if(tasksfailed > tempfail)
            begin
                $display("SEG test failed at i = %d, SEG = %b, expected = %b", i, SEG_tb, displaycheck);
            end
        end

        if(tasksfailed == 0)
            begin
                $display("SEG tests passed");
            end
        else
            begin
                $display("%d SEG tests failed", tasksfailed);
            end  
                
        #5000000;
        $finish;                                  
    end       
    
endmodule
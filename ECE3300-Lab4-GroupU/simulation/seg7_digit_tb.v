`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/08/2026 03:32:54 PM
// Design Name: 
// Module Name: digit_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seg7_digit_tb(
                );
                
    reg clk_tb;
    reg rst;
    reg [31:0] SW;
    wire [6:0] display;
    wire dp;
    wire [7:0] anode;
    seg7_driver seg7_tb(.clk(clk_tb), .rst_n(rst),
                    .SW(SW), .Cnode(display),
                    .dp(dp), .AN(anode));
    
//    initial clk <= 0;
    always begin
        #5 clk_tb = ~clk_tb;
    end
    
    integer i, j, tasksfailed, tempfail;
    reg[6:0] displaycheck;    
    
    initial
    begin
        clk_tb = 0;
        rst = 0;
        i = 0;
        j = 0;
        tasksfailed = 0;
        tempfail = 0;
        for(i=0; i<16; i=i+1)begin
            SW = 16'd0;
            for(j=0; j<8; j=j+1)begin
                SW = SW << 4;
                SW = SW | i;
            end
            
            tempfail = tasksfailed;
            case(i)
                32'h0: displaycheck = 7'b0000001;
                32'h1: displaycheck = 7'b1001111;
                32'h2: displaycheck = 7'b0010010;
                32'h3: displaycheck = 7'b0000110;
                32'h4: displaycheck = 7'b1001100;
                32'h5: displaycheck = 7'b0100100;
                32'h6: displaycheck = 7'b0100000;
                32'h7: displaycheck = 7'b0001111;
                32'h8: displaycheck = 7'b0000000;
                32'h9: displaycheck = 7'b0001100;
                32'ha: displaycheck = 7'b0001000;
                32'hb: displaycheck = 7'b1100000;
                32'hc: displaycheck = 7'b0110001;
                32'hd: displaycheck = 7'b1000010;
                32'he: displaycheck = 7'b0110000;
                32'hf: displaycheck = 7'b0111000;                                                                         
            endcase                             
            #40;
            if(displaycheck != display) tasksfailed = tasksfailed + 1;  
            if(tasksfailed > tempfail) begin
                $display("test failed at: i = %d, j = %d", i, j);
            end           
        end
        if(tasksfailed == 0) begin
            $display("all tests succeed");
        end else begin
            $display("%d tests failed", tasksfailed);
        end
        $finish;
    end
endmodule        

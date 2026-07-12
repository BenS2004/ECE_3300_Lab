`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevensom
// 
// Create Date: 07/10/2026 03:23:58 PM
// Design Name: Clock Divider TestBench
// Module Name: clock_divider_tb
// Project Name: ECE 3300 Lab 5
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


module clock_divider_tb(

    );
    reg clk;
    wire[31:0] counter;
    reg[32:0] i;
    clock_divider div_clk(.clk(clk), .clk_div(counter));
    always #5 clk = ~clk;  
    
    initial begin
        clk = 0;
        for(i=0; i<33'h0ffffffff; i=i+1)begin
            #10;
        end
    end
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson
// 
// Create Date: 07/10/2026 03:10:25 PM
// Design Name: Clock Divider
// Module Name: clock_divider
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


module clock_divider(
    input wire clk,
    output reg [31:0] clk_div
    );
    initial clk_div = 0;
    always@(posedge clk)begin
        clk_div = clk_div + 1;
    end
    
endmodule

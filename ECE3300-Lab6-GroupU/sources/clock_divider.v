`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson & Ben Robles
// 
// Create Date: 07/19/2026 06:42:25 PM
// Design Name: Clock Divider
// Module Name: clock_divider
// Project Name: ECE 3300 Lab 6
// Target Devices: Nexys a7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.03
// Revision 0.01 - File Created
// Revision 0.02 - Simplified design
// Revision 0.03 - Updated from lab 5
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_divider (
                        input wire clk,
                        output reg [31:0] clk_div
                     );
    
    initial clk_div = 0;
    
    always@(posedge clk)
    begin
        clk_div <= clk_div + 1;
    end
    
endmodule
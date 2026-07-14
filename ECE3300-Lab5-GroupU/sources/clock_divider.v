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


module clock_divider #(parameter size = 32)(
    input wire clk,
    output wire [31:0] clk_div
    );
    
    reg [size-1:0] counter;
    initial counter = 0;
    assign clk_div = counter[size-1:size-32];
    always@(posedge clk)begin
        counter = counter + 1;
    end
    
endmodule

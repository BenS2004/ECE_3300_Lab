`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson
// 
// Create Date: 07/27/2026 12:59:04 PM
// Design Name: 2x1 Multiplexer
// Module Name: Mux2x1
// Project Name: ECE 3300 Lab7
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


module Mux2x1#(parameter BUS_SIZE = 16)(
    input wire [BUS_SIZE - 1:0]a,
    input wire [BUS_SIZE - 1:0]b,
    input wire sel,
    output wire [BUS_SIZE - 1:0]y
    );
    
    wire sel_not;
    assign sel_not = ~sel;   
    assign y = (a & sel_not) | (b & sel);
    
endmodule

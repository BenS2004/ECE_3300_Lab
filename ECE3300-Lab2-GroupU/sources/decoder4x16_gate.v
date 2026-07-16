`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2026 12:34:24 PM
// Design Name: 
// Module Name: four_to_sixteen_decoder_gate
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

module decoder4x16_gate(
    input wire [3:0] A, input wire E,
    output wire [15:0] Y
    );
    
    wire a0 = A[0]; wire a0n = ~a0;
    wire a1 = A[1]; wire a1n = ~a1;
    wire a2 = A[2]; wire a2n = ~a2;
    wire a3 = A[3]; wire a3n = ~a3;
    
    assign Y[0] = a0n & a1n & a2n & a3n & E;
    assign Y[1] = a0 & a1n & a2n & a3n & E;
    assign Y[2] = a0n & a1 & a2n & a3n & E;
    assign Y[3] = a0 & a1 & a2n & a3n & E;
    assign Y[4] = a0n & a1n & a2 & a3n & E;
    assign Y[5] = a0 & a1n & a2 & a3n & E;
    assign Y[6] = a0n & a1 & a2 & a3n & E;
    assign Y[7] = a0 & a1 & a2 & a3n & E;
    assign Y[8] = a0n & a1n & a2n & a3 & E;
    assign Y[9] = a0 & a1n & a2n & a3 & E;
    assign Y[10] = a0n & a1 & a2n & a3 & E;
    assign Y[11] = a0 & a1 & a2n & a3 & E;
    assign Y[12] = a0n & a1n & a2 & a3 & E;
    assign Y[13] = a0 & a1n & a2 & a3 & E;
    assign Y[14] = a0n & a1 & a2 & a3 & E;
    assign Y[15] = a0 & a1 & a2 & a3 & E;    
    
endmodule

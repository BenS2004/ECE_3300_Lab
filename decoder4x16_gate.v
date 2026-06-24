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


module four_to_sixteen_decoder_gate(
    input wire [3:0] code, input wire enable,
    output wire [15:0] dest
    );
    
    wire c0 = code[0]; wire c0n = ~c0;
    wire c1 = code[1]; wire c1n = ~c1;
    wire c2 = code[2]; wire c2n = ~c2;
    wire c3 = code[3]; wire c3n = ~c3;
    
    assign dest[0] = c0n & c1n & c2n & c3n & enable;
    assign dest[1] = c0 & c1n & c2n & c3n & enable;
    assign dest[2] = c0n & c1 & c2n & c3n & enable;
    assign dest[3] = c0 & c1 & c2n & c3n & enable;
    assign dest[4] = c0n & c1n & c2 & c3n & enable;
    assign dest[5] = c0 & c1n & c2 & c3n & enable;
    assign dest[6] = c0n & c1 & c2 & c3n & enable;
    assign dest[7] = c0 & c1 & c2 & c3n & enable;
    assign dest[8] = c0n & c1n & c2n & c3 & enable;
    assign dest[9] = c0 & c1n & c2n & c3 & enable;
    assign dest[10] = c0n & c1 & c2n & c3 & enable;
    assign dest[11] = c0 & c1 & c2n & c3 & enable;
    assign dest[12] = c0n & c1n & c2 & c3 & enable;
    assign dest[13] = c0 & c1n & c2 & c3 & enable;
    assign dest[14] = c0n & c1 & c2 & c3 & enable;
    assign dest[15] = c0 & c1 & c2 & c3 & enable;    
    
endmodule

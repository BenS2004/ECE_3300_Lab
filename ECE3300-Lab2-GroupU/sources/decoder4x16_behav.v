`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson
// 
// Create Date: 06/19/2026 08:30:58 PM
// Design Name: Four to Sixteen Decoder
// Module Name: decoder4x16_behav
// Project Name: ECE3300_Lab2_GroupU
// Target Devices: Nexys A7
// Tool Versions: Vivado 25.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder4x16_behav(
    input wire [3:0] A, input wire E,
    output wire [15:0] Y
        );
    
   reg [15:0]destin;
   integer i;
   
   always @(*) begin
        destin = 16'b0;
        if(E)begin
            for(i = 0; i < 16; i = i + 1)begin
                destin[i] = (A == i);
            end
        end
   end
   assign Y = destin;
   endmodule


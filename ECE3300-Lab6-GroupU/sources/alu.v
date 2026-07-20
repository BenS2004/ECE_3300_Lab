`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 07/19/2026 06:52:07 PM
// Design Name: 4 bit alu
// Module Name: alu
// Project Name: ECE 3300 Group U Lab 6
// Target Devices: Nexys a7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.01
// Revision 0.01 - File Created
// Additional Comments: 
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
                input [3:0] a,
                input [3:0] b,
                input [1:0] ctrl,
                output reg [7:0] result
          );    
          
    always@(*) begin
        case(ctrl)
            2'b00: result = {4'b0000, a} + {4'b0000, b};
            2'b01: result = {4'b0000, a} - {4'b0000, b};
            default: result = 8'b0;
        endcase   
    end     
          
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 07/19/2026 07:03:45 PM
// Design Name: alu control decoder
// Module Name: control_decoder
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


module control_decoder(
                            input [3:0] inp,
                            output wire [3:0] ctrl
                  );                                
    assign ctrl = inp;   
                         
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 09:27:17 PM
// Design Name: 
// Module Name: four_to_sixteen_decoder_top
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


module four_to_sixteen_decoder_top(
    input wire[4:0] SW,
    output wire[15:0] LED
    );
    
    four_to_sixteen_decoder_behave M1(.code(SW[3:0]),
     .enable(SW[4]), .dest(LED));
     //four_to_sixteen_decoder_gate M2(.code(SW[3:0]),
     //.enable(SW[4]), .dest(LED));
    
endmodule

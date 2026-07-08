`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2026 09:18:44 PM
// Design Name: 
// Module Name: Lab_two_simulation
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


module Lab_two_simulation(
    );
    
    reg [4:0] switch;
    wire [15:0] light;
    
    four_to_sixteen_decoder_top TB(
    .SW(switch), .LED(light)
    );
    
    initial begin
    
    switch = 5'h10;
    #20
    switch = 5'h11;
    #20
    switch = 5'h12;
    #20
    switch = 5'h14;
    #20
    switch = 5'h18;
    #20
    switch = 5'h13;
    #20
    switch = 5'h15;
    #20
    switch = 5'h17;
    #20
    switch = 5'h1f;
    #20
    switch = 5'h0f;
    #20
    $finish;
    
    end
    
endmodule

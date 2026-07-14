`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson
// 
// Create Date: 07/12/2026 02:05:05 PM
// Design Name: Debouncing Logic
// Module Name: debounce
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


module debounce(
    input wire clk,
    input wire btn_raw,
    output reg btn_clean
    );
    
    reg[2:0] state;
    initial state = 3'b000;
    
    always @(posedge clk)begin
        state = {state[1:0], btn_raw};
        if(state == 3'b000) btn_clean = 0;
        else if (state == 3'b111) btn_clean = 1;
    end
endmodule

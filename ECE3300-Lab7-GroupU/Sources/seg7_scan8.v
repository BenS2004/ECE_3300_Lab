`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 07/28/2026 07:43:49 PM
// Design Name: 4 digit output on 7seg scanner
// Module Name: seg7_scan8
// Project Name: ECE3300_Lab7_GroupU
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


module seg7_scan8(
                        input clk_1kHz,
                        input rst_n,
                        input [15:0] word,
                        output reg [7:0] AN,
                        output reg [6:0] SEG
                 );
             
    reg [2:0] sel;
    
    wire [6:0] digit0;
    wire [6:0] digit1;
    wire [6:0] digit2;
    wire [6:0] digit3;      
    
    hex_to_7seg hex0(
        .hex(word[3:0]),
        .digit(digit0)
    );

    hex_to_7seg hex1(
        .hex(word[7:4]),
        .digit(digit1)
    );

    hex_to_7seg hex2(
        .hex(word[11:8]),
        .digit(digit2)
    );

    hex_to_7seg hex3(
        .hex(word[15:12]),
        .digit(digit3)
    );              
         
    always @(posedge clk_1kHz or negedge rst_n) begin
        if(!rst_n)
            sel <= 3'b000;
        else 
            sel <= sel + 1'b1;
    end                     
    
    always @(*) begin
        case(sel)
            3'd0: begin
                AN = 8'b11111110;
                SEG = digit0;
            end
            3'd1: begin
                AN = 8'b11111101;
                SEG = digit1;
            end
            3'd2: begin
                AN = 8'b11111011;
                SEG = digit2;
            end   
            3'd3: begin
                AN = 8'b11110111;
                SEG = digit3;
            end    
            default: begin
                AN = 8'b11111111;
                SEG = 7'b1111111;
            end 
        endcase
    end
                 
endmodule

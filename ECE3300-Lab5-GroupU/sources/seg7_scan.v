`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson
// 
// Create Date: 07/10/2026 03:10:25 PM
// Design Name: Seven Segment Display Scan
// Module Name: seg7_scan
// Project Name: ECE 3300 Group U Lab 5
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


module seg7_scan(
    input [7:0] BCD,
    output wire [7:0] AN,
    output reg [6:0] SEG,
    input clk
    );
    
    reg [19:0] temp;
    reg [3:0] digit;
    reg [7:0] AN_tmp;
    always@(posedge clk)
        temp = temp + 1;
    wire[2:0] s = temp[19:17];
       
    always @(s, BCD) begin
        case(s)
           3'b0: digit = BCD[3:0];
           3'b1: digit = BCD[7:4];
           default: digit = 0;
        endcase
    end
    
    always @(s) begin
        case(s)
            3'd0:AN_tmp=8'b11111110;3'd1:AN_tmp=8'b11111101;
            3'd2:AN_tmp=8'b11111011;3'd3:AN_tmp=8'b11110111;
            3'd4:AN_tmp=8'b11101111;3'd5:AN_tmp=8'b11011111;
            3'd6:AN_tmp=8'b10111111;3'd7:AN_tmp=8'b01111111;
            default:AN_tmp=8'b11111111;
        endcase
    end
    
    assign AN = AN_tmp;
    
    always @(digit)begin
        case(digit)
             4'd0: SEG=7'b0000001; 4'd1: SEG=7'b1001111; 4'd2: SEG=7'b0010010;
             4'd3: SEG=7'b0000110; 4'd4: SEG=7'b1001100; 4'd5: SEG=7'b0100100;
             4'd6: SEG=7'b0100000; 4'd7: SEG=7'b0001111; 4'd8: SEG=7'b0000000;
             4'd9: SEG=7'b0001100; default: SEG=7'b1111111;
         endcase
    end
    
endmodule


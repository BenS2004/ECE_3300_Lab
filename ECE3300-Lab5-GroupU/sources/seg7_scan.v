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
    output reg [7:0] AN,
    output reg [6:0] SEG,
    input clk
    );
    
    reg [17:0] temp;
    reg [3:0] digit;
    
    always@(posedge clk)
        temp = temp + 1;
    wire s = temp[17];
       
    always @(s, BCD) begin
        case(s)
            1'b0: digit = BCD[3:0];
            1'b1: digit = BCD[7:4];
        endcase
    end
    
    always @(s) begin
        case(s)
            1'b0: AN = 11111110;
            1'b1: AN = 11111101;
            default: AN = 11111111;
        endcase
    end
    
    always @(digit)begin
        case(digit)
             4'd0: SEG=7'b0000001; 4'd1: SEG=7'b1001111; 4'd2: SEG=7'b0010010;
             4'd3: SEG=7'b0000110; 4'd4: SEG=7'b1001100; 4'd5: SEG=7'b0100100;
             4'd6: SEG=7'b0100000; 4'd7: SEG=7'b0001111; 4'd8: SEG=7'b0000000;
             4'd9: SEG=7'b0001100; default: SEG=7'b1111111;
         endcase
    end
    
endmodule

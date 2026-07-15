`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson & Ben Robles
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
// Revision 0.02 - Simplified design
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seg7_scan(
                    input clk,
                    input rst_n,
                    input [7:0] BCD,
                    output reg [7:0] AN,
                    output reg [6:0] SEG
                );
    
    reg [19:0] temp;
    reg [3:0] digit;
    
    wire s;
    assign s = temp[17];
    
    always@(posedge clk)
    begin
        if (!rst_n)
            temp <= 0;
        else
            temp <= temp + 1;
    end
        
    always@(*)
    begin
        case(s)
            1'b0: begin
                digit = BCD[3:0];
                AN = 8'b11111110;
            end
            
            1'b1: begin
                digit = BCD[7:4];
                AN = 8'b11111101;
            end
            
            default: begin
                digit = 0;
                AN = 8'b11111111;
            end     
        endcase     
    end
        
    always @(*)
    begin
        case(digit)
             4'd0: SEG=7'b0000001; 4'd1: SEG=7'b1001111; 4'd2: SEG=7'b0010010;
             4'd3: SEG=7'b0000110; 4'd4: SEG=7'b1001100; 4'd5: SEG=7'b0100100;
             4'd6: SEG=7'b0100000; 4'd7: SEG=7'b0001111; 4'd8: SEG=7'b0000000;
             4'd9: SEG=7'b0001100; default: SEG=7'b1111111;
         endcase
    end
    
endmodule

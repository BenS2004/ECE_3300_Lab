`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson & Ben Robles
// 
// Create Date: 07/19/2026 07:11:25 PM
// Design Name: Seven Segment Display Scan
// Module Name: seg7_scan
// Project Name: ECE 3300 Group U Lab 6
// Target Devices: Nexys a7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.03
// Revision 0.01 - File Created
// Revision 0.02 - Simplified design
// Revision 0.03 - Updated from lab 5
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seg7_scan(
                    input clk,
                    input rst_n,
                    input [7:0] result,
                    input [3:0] ctrl_nibble,
                    output reg [7:0] AN,
                    output reg [6:0] SEG
                );
    
    reg [19:0] temp;
    reg [3:0] digit;
    
    wire [1:0] s;
    assign s = temp[18:17];
    
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
            2'b00: begin
                digit = result[3:0];
                AN = 8'b11111110;
            end
            
            2'b01: begin
                digit = result[7:4];
                AN = 8'b11111101;
            end
            
            2'b10: begin
                digit = ctrl_nibble;
                AN = 8'b11111011;
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
            4'd0: SEG=7'b0000001; 
            4'd1: SEG=7'b1001111; 
            4'd2: SEG=7'b0010010;
            4'd3: SEG=7'b0000110; 
            4'd4: SEG=7'b1001100; 
            4'd5: SEG=7'b0100100;
            4'd6: SEG=7'b0100000; 
            4'd7: SEG=7'b0001111; 
            4'd8: SEG=7'b0000000;
            4'd9: SEG=7'b0001100; 
            4'd10:SEG=7'b0001000;
            4'd11:SEG=7'b1100000;
            4'd12:SEG=7'b0110001;
            4'd13:SEG=7'b1000010;
            4'd14:SEG=7'b0110000;
            4'd15:SEG=7'b0111000;
            default: SEG=7'b1111111;
        endcase
    end
endmodule
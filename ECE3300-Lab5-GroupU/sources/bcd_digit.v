`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 07/14/2026 09:25:33 PM
// Design Name: Cascading BCD digit
// Module Name: bcd_digit
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


module bcd_digit(
                    input clk,
                    input rst_n,
                    input en,
                    input dir,
                    output reg [3:0] digit,
                    output wire rollover
                );
                
    assign rollover = en && ((dir && digit == 4'd9) || (!dir && digit == 4'd0));
    
    always@(posedge clk) begin
        if (!rst_n) begin
            digit <= 4'd0;  
        end
        
        else if (en) begin
            if (dir) begin
                if (digit == 4'd9)
                    digit <= 4'd0;
                else
                    digit <= digit + 4'd1;
            end
            else begin
                if (digit == 4'd0)
                    digit <= 4'd9;
                else
                    digit <= digit - 4'd1;            
            end
        end    
    end
endmodule

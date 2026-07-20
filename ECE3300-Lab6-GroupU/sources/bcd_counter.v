`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 07/19/2026 06:45:33 PM
// Design Name: BCD single digit counter
// Module Name: bcd_counter
// Project Name: ECE 3300 Group U Lab 6
// Target Devices: Nexys a7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.02
// Revision 0.01 - File Created
// Revision 0.02 - Updated from lab 5
// Additional Comments: 
// 
//////////////////////////////////////////////////////////////////////////////////


module bcd_counter(
                        input clk,
                        input rst_n,
                        input dir,
                        output reg [3:0] digit
                  );
                    
    always@(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            digit <= 4'd0;  
        end
        else begin
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
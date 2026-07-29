`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson & Ben Robles
// 
// Create Date: 07/27/2026 12:49:10 PM
// Design Name: Shift Amount Counter
// Module Name: shamt_counter
// Project Name: ECE 3300 Lab 7
// Target Devices: Nexys a7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.02
// Revision 0.01 - File Created
// Revision 0.02 - Updated
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module shamt_counter(
                        input wire clk_1kHz,
                        input wire rst_n,
                        input wire btn_toggle,
                        output reg [1:0] shamt_high
                    );

    reg btn_prev;
    
    always @(posedge clk_1kHz or negedge rst_n) begin
        if(!rst_n) begin
            shamt_high <= 2'b00;
            btn_prev <= 1'b0;
        end
        else begin
            btn_prev <= btn_toggle;
            
            if(btn_toggle != btn_prev)
                shamt_high <= shamt_high + 2'b01;
        end
    end

endmodule

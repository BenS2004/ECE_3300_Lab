`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson & Ben Robles
// 
// Create Date: 07/27/2026 12:49:10 PM
// Design Name: Debounced Toggle Flip Flop
// Module Name: debounce_toggle
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


module debounce_toggle(
                            input wire btn_raw,
                            input wire clk_1kHz,
                            input wire rst_n,
                            output reg btn_toggle
    );
    // Debounce
    reg [2:0] btn_val;
    reg btn_clean;
    reg btn_prev;
            
    always @(posedge clk_1kHz or negedge rst_n) begin
        if(!rst_n) begin
            btn_val = 3'b000;
            btn_clean = 1'b0;
        end
        else begin
            btn_val = {btn_val[1:0], btn_raw};
            if(btn_val == 3'b111) btn_clean = 1;
            else if(btn_val == 3'b000) btn_clean = 0;
        end
    end
    
    // Toggle
    always @(posedge clk_1kHz or negedge rst_n) begin
        if (!rst_n) begin
            btn_toggle <= 1'b0;
            btn_prev <= 1'b0;
        end
        else begin
            if(btn_clean && !btn_prev) 
                btn_toggle <= ~btn_toggle;
                
            btn_prev <= btn_clean;
        end
    end
    
endmodule
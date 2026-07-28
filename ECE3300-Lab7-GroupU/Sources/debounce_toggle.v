`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson
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
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module debounce_toggle(
    input wire btn_raw,
    input wire clk,
    input wire rst,
    output reg data_out
    );
    // Debounce
    reg [2:0] btn_val;
    reg btn_clean;
    initial begin
        btn_val = 3'b0;
        btn_clean = 1'b0;
        data_out = 1'b0;
    end
    
    always @(posedge clk, posedge rst) begin
        if(rst == 1) begin
        btn_val = 3'b000;
        btn_clean = 1'b0;
        data_out = 1'b0;        
        end else begin
            btn_val = {btn_val[1:0], btn_raw};
            if(btn_val == 3'b111) begin
                btn_clean = 1;
            end else if(btn_val == 3'b000) begin
                btn_clean = 0;
            end
        end
    end
    
    //toggle
    always @(posedge btn_clean)begin
        if(rst == 0)begin
        data_out = ~data_out;
        end 
    end
    
endmodule

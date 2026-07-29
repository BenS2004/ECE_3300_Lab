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
                        input wire btn_raw,
                        output reg [1:0] shamt_high
                    );
                    
    reg [2:0] btn_val;
    reg btn_clean;
    reg btn_prev;
    
    initial begin
        btn_val = 3'b000;
        btn_clean = 1'b0;
        btn_prev = 1'b0;
        shamt_high = 2'b00;
    end
    
    always @(posedge clk_1kHz) begin
        btn_prev = btn_clean;
        btn_val = {btn_val[1:0], btn_raw};
        
        if(btn_val == 3'b111) btn_clean = 1;
        else if(btn_val == 3'b000) btn_clean = 0;
        
        if(btn_clean && !btn_prev)
            shamt_high = shamt_high + 1'b1; 
    end

endmodule

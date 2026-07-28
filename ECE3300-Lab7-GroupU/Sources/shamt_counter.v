`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson
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
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module shamt_counter(
    input wire btn_raw,
    input wire clk,
    output reg btn_clean,
    output reg[1:0] amt_out
    );
    //debounce
    reg[2:0] btn_val;    
    
    initial begin
        btn_val = 3'b000;
        btn_clean = 1'b0;
        amt_out = 2'b00;
    end
    
    always @(posedge clk)begin
        btn_val = {btn_val[1:0], btn_raw};
        if(btn_val == 3'b000)begin
            btn_clean = 0;
        end else if(btn_val == 3'b111)begin
            btn_clean = 1;
        end
    end
    
    //increment amt
    
    always @(posedge btn_clean)begin
        amt_out = amt_out + 1;
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2026 02:45:03 PM
// Design Name: 
// Module Name: top_mux_lab3
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_mux_lab3(
    input CLK100MHZ,
    input [15:0] SW,
    input BTNU, BTND, BTNL, BTNR, BTNC,
    output [0:0] LED
    );
    
    wire [3:0] sel;
    
    toggle_switch t0 (.clk(CLK100MHZ), .rst(BTNC), .btn_raw(BTND), .state(sel[0]));
    toggle_switch t1 (.clk(CLK100MHZ), .rst(BTNC), .btn_raw(BTNR), .state(sel[1]));
    toggle_switch t2 (.clk(CLK100MHZ), .rst(BTNC), .btn_raw(BTNL), .state(sel[2]));
    toggle_switch t3 (.clk(CLK100MHZ), .rst(BTNC), .btn_raw(BTNU), .state(sel[3]));
    
    mux16x1 mux (.in(SW), .sel(sel), .out(LED[0]));
    
endmodule

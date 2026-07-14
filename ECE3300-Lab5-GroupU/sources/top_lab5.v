`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/10/2026 03:10:25 PM
// Design Name: 
// Module Name: top_lab5
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


module top_lab5(
    input CLK100MHZ, BTNC, BTNU,
    input [4:0] SW,
    output [6:0] SEG,
    output [7:0] AN,
    output [12:0] LED
    );
    wire[31:0] counter;
    wire slow_clk, rst, dir_clean, dir;
    wire[7:0] BCD;
    
    clock_divider #(.size(50))clock_division(.clk(CLK100MHZ), .clk_div(counter));   
    
    mux32x1 counter_multiplexer(.in(counter), .sel(SW[4:0]), .out(slow_clk));
    
    debounce debounce_rst(.btn_raw(BTNC), .btn_clean(rst), .clk(CLK100MHZ));
    
    debounce debounce_dir(.btn_raw(BTNU), .btn_clean(dir_clean), .clk(CLK100MHZ));
    
    toggle_ff toggle_dir(.clk(CLK100MHZ), .rst(rst), .data(dir_clean), .state(dir));
    
    bcd_up_down_counter bcd_counter(.clk(slow_clk), .rst(rst), .dir(dir), .BCD(BCD));
    
    assign LED[0] = SW[0];
    assign LED[1] = SW[1];
    assign LED[2] = SW[2];
    assign LED[3] = SW[3];
    assign LED[4] = SW[4];
    assign LED[5] = BCD[0];
    assign LED[6] = BCD[1];
    assign LED[7] = BCD[2];
    assign LED[8] = BCD[3];
    assign LED[9] = BCD[4];
    assign LED[10] = BCD[5];
    assign LED[11] = BCD[6];
    assign LED[12] = BCD[7];

   seg7_scan seg7_out(.BCD(BCD), .AN(AN), .SEG(SEG), .clk(CLK100MHZ));
    
endmodule

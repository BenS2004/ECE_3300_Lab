`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 07/28/2026 08:05:49 PM
// Design Name: Barrel shifter top file
// Module Name: top_lab7
// Project Name: ECE3300_Lab7_GroupU
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

module top_lab7(
                    input CLK_100MHz,
                    input [15:0] SW,
                    input BTNC, BTNU, BTND, BTNL, BTNR,
                    output wire [7:0] AN,
                    output wire [6:0] SEG,
                    output wire [7:0] LED
               );
           
    wire RST_N;
    assign RST_N = ~BTNC;
    
    wire CLK_1kHz;
    wire CLK_2Hz;
    
    wire DIR;
    wire ROTATE;
    
    wire [1:0] SHAMT_LOW;
    wire [1:0] SHAMT_HIGH;
       
    wire [15:0] BARREL_OUT; 
    wire [15:0] RESULT_WORD;

        
    clock_divider_fixed clk_divs(
                                    .clk_100MHz(CLK_100MHz),
                                    .clk_2Hz(CLK_2Hz),
                                    .clk_1kHz(CLK_1kHz)
                                );                                
    
    debounce_toggle debounce_btnu(
                                        . btn_raw(BTNU),
                                        .clk_1kHz(CLK_1kHz),
                                        .rst_n(RST_N),
                                        .btn_toggle(DIR)
                                 ); 
                                 
    debounce_toggle debounce_btnd(
                                        . btn_raw(BTND),
                                        .clk_1kHz(CLK_1kHz),
                                        .rst_n(RST_N),
                                        .btn_toggle(ROTATE)
                                 );  
                                        
    debounce_toggle debounce_btnl(
                                        . btn_raw(BTNL),
                                        .clk_1kHz(CLK_1kHz),
                                        .rst_n(RST_N),
                                        .btn_toggle(SHAMT_LOW[1])
                                 );   
                                       
    debounce_toggle debounce_btnr(
                                        . btn_raw(BTNR),
                                        .clk_1kHz(CLK_1kHz),
                                        .rst_n(RST_N),
                                        .btn_toggle(SHAMT_LOW[0])
                                 );       
                           
    shamt_counter shamt_count(
                                    .clk_1kHz(CLK_1kHz),
                                    .btn_raw(BTNC),
                                    .shamt_high(SHAMT_HIGH)
                             );                                                                  
                            
    barrel_shifter16 shifter(
                                .data_in(SW),
                                .shamt({SHAMT_HIGH, SHAMT_LOW}),
                                .dir(DIR),
                                .rotate(ROTATE),
                                .data_out(BARREL_OUT)
                            );   
                            
    assign RESULT_WORD = BARREL_OUT;            
                        
    seg7_scan8 display(
                            .clk_1kHz(CLK_1kHz),
                            .rst_n(RST_N),
                            .word(RESULT_WORD),
                            .an(AN),
                            .seg(SEG)
                      );           
              
                 
    assign LED = {DIR, ROTATE, 2'b00, {SHAMT_HIGH, SHAMT_LOW}};                                                                    
               
endmodule

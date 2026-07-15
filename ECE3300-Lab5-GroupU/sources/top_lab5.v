`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson & Ben Robles
// 
// Create Date: 07/10/2026 03:10:25 PM
// Design Name: bcd counter
// Module Name: top_lab5
// Project Name: ECE 3300 Group U Lab 5
// Target Devices: Nexys a7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - Simplified design
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_lab5(
                    input CLK100MHZ, 
                    input BTNC, 
                    input BTNU,
                    input [4:0] SW,
                    output wire [6:0] seg,
                    output wire [7:0] an,
                    output wire [12:0] LED
               );
               
    wire[31:0] counter;
    wire slow_clk; 
    
    wire[7:0] BCD;
    
    wire rst;
    wire rst_n;
    
    wire dir;
    
    assign rst_n = ~rst;
    
    clock_divider clock_division(
                                     .clk(CLK100MHZ), 
                                     .clk_div(counter)
                                );   
    
    mux32x1 counter_multiplexer(
                                    .in(counter), 
                                    .sel(~SW),
                                    .out(slow_clk)
                               );
    
    debounce debounce_rst(
                              .btn_raw(BTNC),
                              .btn_clean(rst), 
                              .clk(CLK100MHZ)
                         );                                  
    
    toggle_ff toggle_dir(
                             .clk(CLK100MHZ),
                             .rst_n(rst_n),
                             .btn_raw(BTNU),
                             .state(dir)
                        );
    
    bcd_up_down_counter bcd_counter(
                                        .clk(slow_clk), 
                                        .rst_n(rst_n),
                                        .dir(dir),
                                        .BCD(BCD)
                                   );
    
    seg7_scan seg7_out(
                           .BCD(BCD), 
                           .AN(an),
                           .SEG(seg),
                           .clk(CLK100MHZ),
                           .rst_n(rst_n)
                      );
   
   assign LED[4:0] = SW;
   assign LED[12:5] = BCD;
       
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 07/19/2026 07:22:54 PM
// Design Name: top lab 6
// Module Name: top_lab6
// Project Name: ECE 3300 Group U Lab 6
// Target Devices: Nexys a7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.01
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_lab6(
                    input CLK,
                    input [8:0] SW,
                    input BTNC,
                    output wire [7:0] AN,
                    output wire [6:0] SEG,
                    output wire [7:0] LED
               );
               
    wire rst, rst_n;
    assign rst_n = ~rst;    
           
    wire[31:0] counter;
    wire slow_clk;  
    
    wire [3:0] ctrl_nibble;
    wire [3:0] count_ones;
    wire [3:0] count_tens;   
    wire [7:0] result;       
       
    clock_divider clock_division(
                                     .clk(CLK), 
                                     .clk_div(counter)
                                );   
    
    mux32x1 counter_multiplexer(
                                    .in(counter), 
                                    .sel(~SW[4:0]),
                                    .out(slow_clk)
                               );
    
    debounce debounce_rst(
                              .btn_raw(BTNC),
                              .btn_clean(rst), 
                              .clk(CLK)
                         );  
                         
   control_decoder ctrl_out (
                                .inp(SW[8:5]),
                                .ctrl(ctrl_nibble)
                            );                  
                     
    bcd_counter counter_ones (
                            .clk(slow_clk),
                            .rst_n(rst_n),
                            .dir(SW[7]),
                            .digit(count_ones)
                        );      
                        
    bcd_counter counter_tens (
                            .clk(slow_clk),
                            .rst_n(rst_n),
                            .dir(SW[8]),
                            .digit(count_tens)
                        );   
                
    assign LED = {count_tens, count_ones};                  
    
    alu bcd_alu (
                    .ctrl(SW[6:5]),
                    .a(count_ones),
                    .b(count_tens),
                    .result(result)
                );    
                
    seg7_scan seg7_out(
                           .clk(CLK),
                           .rst_n(rst_n),
                           .result(result), 
                           .ctrl_nibble(ctrl_nibble),
                           .AN(AN),
                           .SEG(SEG)
                      );    
                                                                                                             
endmodule

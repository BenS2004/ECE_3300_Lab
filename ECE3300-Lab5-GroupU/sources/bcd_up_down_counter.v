`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 07/10/2026 03:10:25 PM
// Design Name: Cascading BCD Up Down Counter
// Module Name: bcd_up_down_counter
// Project Name: ECE 3300 Group U Lab 5
// Target Devices: Nexys a7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - Adjusted design
// Additional Comments: 
// 
//////////////////////////////////////////////////////////////////////////////////


module bcd_up_down_counter(
                            input clk,
                            input rst_n,
                            input dir,
                            output wire [7:0] BCD
    );
    
    wire [3:0] ones;
    wire [3:0] tens;
    wire rollover;
    
    bcd_digit ones_counter(
                                .clk(clk),
                                .rst_n(rst_n),
                                .en(1'b1),
                                .dir(dir),
                                .digit(ones),
                                .rollover(rollover)
                          );
                          
    bcd_digit tens_counter(
                                .clk(clk),
                                .rst_n(rst_n),
                                .en(rollover),
                                .dir(dir),
                                .digit(tens),
                                .rollover()
                          );
                          
  assign BCD = {tens, ones};

endmodule

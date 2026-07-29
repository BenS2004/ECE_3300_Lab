`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson & Ben Robles
// 
// Create Date: 07/27/2026 12:49:10 PM
// Design Name: Fixed Clock Divider
// Module Name: clock_divider_fixed
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


module clock_divider_fixed(
                                input wire clk_100MHz,
                                output reg clk_2Hz,
                                output reg clk_1kHz
                          );
                      
    reg [15:0] counter_1kHz;
    reg [7:0] counter_2Hz;
    
    initial begin
        counter_2Hz = 0;
        counter_1kHz = 0;
        clk_2Hz = 0;
        clk_1kHz = 0;
    end
    
    always @(posedge clk_100MHz) begin
        if(counter_1kHz == 16'd49_999) begin      // 100MHz / (2 x 50000) = 1kHz
            counter_1kHz <= 0;
            clk_1kHz <= ~clk_1kHz;
        end
        else counter_1kHz <= counter_1kHz + 1'b1;
    end
    
    always @(posedge clk_1kHz) begin
        if(counter_2Hz == 8'd249) begin           //  1kHz / (2 * 250) = 2Hz   
            counter_2Hz <= 0;
            clk_2Hz <= ~clk_2Hz;
        end  
        else counter_2Hz <= counter_2Hz + 1'b1;        
    end 
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2026 12:49:10 PM
// Design Name: 
// Module Name: clock_divider_fixed
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


module clock_divider_fixed #(parameter DIV_VALUE = 26'd50000000)(
    input wire clk_10kHz,
    output reg clk_div
    );
         
    integer counter;
    
    initial begin
        clk_div = 1'b0;        
        counter = 32'b0;
        clk_div = 1'b1;
    end
    
    always @(posedge clk_10kHz)begin
        counter = counter + 1;
        if(counter == DIV_VALUE)begin
            counter = 0;   
            clk_div = ~clk_div;
        end   
         
    end
   
    
endmodule

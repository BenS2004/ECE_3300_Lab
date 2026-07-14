`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2026 02:41:35 PM
// Design Name: 
// Module Name: toggle_ff
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


module toggle_ff(
    input wire clk,
    input wire rst,
    input wire data,
    output reg state
    );
    
    initial state = 0;
    
    always @(posedge clk) begin
        if(rst == 1) state = 0; else begin
            if(data == 1) state = ~state;
        end
    end
    
endmodule

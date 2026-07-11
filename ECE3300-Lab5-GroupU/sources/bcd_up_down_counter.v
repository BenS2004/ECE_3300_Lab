`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevensom
// 
// Create Date: 07/10/2026 03:10:25 PM
// Design Name: BCD Up Down Counter
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
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bcd_up_down_counter(
    input wire clk,
    input wire rst,
    input wire dir,
    output reg [7:0] BCD
    );
    
    reg [8:0] count;
    reg [4:0] ones, tens;
    
    always@(posedge clk | rst)begin
        if(rst) count = 0;
        else begin
            if(dir == 0) count = count+1;
            else count = count - 1;
            ones = count % 10;
            tens = count / 10;
            BCD = {tens, ones};
        end
    end             
    
endmodule

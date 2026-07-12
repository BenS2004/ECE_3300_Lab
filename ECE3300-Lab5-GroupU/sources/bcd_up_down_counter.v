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
    
    initial begin count = 0; BCD = 0; end
    reg[4:0] i;
    always@(posedge clk | rst)begin
        if(rst) BCD = 0;
        else begin
            if(dir == 0)begin
                BCD = (BCD + 1) % 8'h9a;
                if(BCD[3:0] >= 4'b1010) BCD = BCD + 4'b0110;
            end
            else begin 
                BCD = ((BCD + 8'h9a) - 1) % 8'h9a;
                if(BCD[3:0] == 4'b1111) BCD = BCD - 4'b0110;
            end            
        end
    end             
    
endmodule

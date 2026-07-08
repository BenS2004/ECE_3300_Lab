`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2026 04:18:13 PM
// Design Name: 
// Module Name: Debounce_TB
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


module Debounce_TB(
    //input clk
    );
    
    reg btn_in;
    wire btn_out;
    reg clk;
    debounce db_tb(.clk(clk), .btn_in(btn_in),
        .btn_clean(btn_out));
    
    integer i, j;
    reg[2:0] serial_in;
    initial begin
    
        btn_in <= 0;
        serial_in <= 3'b000;
        clk <=0;
        for(i=0; i<8; i=i+1)begin
            serial_in = i;
            for(j=0; j<3; j=j+1)begin
                btn_in = serial_in[j];
                clk <= 1;
                #10;
                clk <= 0;
                #10;
            end
        end
        for(i=7; i>=0; i=i-1)begin
            serial_in = i;
            for(j=0; j<3; j=j+1)begin
                btn_in = serial_in[j];
                clk <= 1;
                #10;
                clk <= 0;
                #10;
            end
        end
    
    $finish;
    end
    
endmodule

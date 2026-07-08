`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2026 06:52:38 PM
// Design Name: 
// Module Name: mux16x4_TestBench
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


module mux16x4_TestBench(

    );
    
    reg [15:0] in;
    reg [3:0] sel;
    wire out;
    mux16x1 mx16_tb(.in(in), .sel(sel), .out(out));
    integer i, j;
    
    initial begin
        in <= 16'd0;
        sel <= 4'd0;
        for(i=0; i<16; i=i+1)begin
            sel <= i;
            for(j=0; j<16; j=j+1)begin
                in[j] = 1;
                #10;
                in[j] = 0;
                #10;
            end
        end
        $finish;
    end
    
    
endmodule

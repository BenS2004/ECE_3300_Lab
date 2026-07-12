`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevensom
// 
// Create Date: 07/10/2026 03:23:58 PM
// Design Name: Seven Segment TestBench
// Module Name: seg7_scan_tb
// Project Name: ECE 3300 Lab 5
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


module seg7_scan_tb(

    );
    
    reg [7:0] BCD;
    wire [7:0] AN;
    wire [6:0] SEG;
    reg clk;
    
    seg7_scan seg7_tb(.BCD(BCD), .clk(clk), .AN(AN), .SEG(SEG));
    
    always #5 clk = ~clk;
    
    integer i, j, tasksfailed;
    
    initial begin
        for(i=0; i<10; i=i+1)begin
            for(j=0; j<10; j=j+1)begin
                
            end
        end
    end
    
endmodule

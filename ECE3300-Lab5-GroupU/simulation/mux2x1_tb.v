`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson
// 
// Create Date: 07/10/2026 03:10:25 PM
// Design Name: mux2x1 test bench
// Module Name: mux2x1_tb
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


module mux2x1_tb(
    
    );
    reg a, b, sel;
    wire y;
    integer tasksfailed, tempfailed; 
    reg check;
    reg [1:0] i, j, k, in;
    mux2x1 mux_tb(.a(a), .b(b), .sel(sel), .y(y));
    
    initial begin
        a <= 0;
        b <= 0;
        sel <= 0;
        tasksfailed <= 0;
        tempfailed <= 0;
        for(i=0; i<2; i=i+1)begin
            sel = i;
            for(j=0; j<2; j=j+1)begin
                a = j;
                for(k=0; k<2; k=k+1)begin
                    b = k;
                    in = {b, a};
                    check = y;
                    #10;
                    if(check != in[sel]) tasksfailed = tasksfailed + 1;
                    if(tasksfailed > tempfailed) $display("Test failed at %d, %d, %d", i, j, k);
                    tempfailed = tasksfailed;                   
                end
            end
        end
        $finish;
    end
    
    
endmodule
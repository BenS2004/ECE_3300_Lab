`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson
// 
// Create Date: 07/10/2026 03:10:25 PM
// Design Name: mux32x1 test bench
// Module Name: mux32x1_tb
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


module mux32x1_tb(
    
    );
    
    reg[31:0] in;
    reg[4:0] sel;
    wire out;
    
    mux32x1 mux_tb(.in(in), .sel(sel), .out(out));
    
    integer i, tasksfailed;
    
    initial begin
        in = 32'b0;
        sel = 5'b0;
        tasksfailed = 0;
        for(i=0; i<32; i=i+1)begin
            in[i] = 1;
            #5;
            if(out != in[i]) begin 
                tasksfailed = tasksfailed + 1;
                $display("test failed");
            end            
            in[i] = 0;
            #5;
            if(out != in[i]) begin 
                tasksfailed = tasksfailed + 1;
                $display("test failed");
            end            
            sel = sel+1;
        end
        if(tasksfailed != 0) $display("%d tasks failed", tasksfailed); else $display("all tasks succeeded");
         $finish;
    end
    
endmodule
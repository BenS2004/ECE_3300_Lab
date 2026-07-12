`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevensom
// 
// Create Date: 07/10/2026 03:23:58 PM
// Design Name: BCD Counter TestBench
// Module Name: bcd_up_down_counter_tb
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


module bcd_up_down_counter_tb(

    );
      
    reg clk;
    reg rst;
    reg dir;
    wire [7:0] BCD;   
    
    bcd_up_down_counter counter_tb(.clk(clk), .rst(rst), .dir(dir), .BCD(BCD));
    
    always #5 clk = ~clk;
    
    integer i, tasksfailed;
    initial begin
        clk = 0;
        rst = 0;
        dir = 0;
        tasksfailed = 0;
        for(i=0; i<100; i=i+1)begin
            #10;
            if(BCD[3:0] != (i % 10)) tasksfailed = tasksfailed + 1;
            if(BCD[7:4] != (i / 10)) tasksfailed = tasksfailed + 1;            
        end
            rst = 1;
            #10;
            rst = 0;
            dir = 0;
        for(i=100; i>=0; i=i-1)begin
            #10;
            if(BCD[3:0] != (i % 10)) tasksfailed = tasksfailed + 1;
            if(BCD[7:4] != (i / 10)) tasksfailed = tasksfailed + 1;        
        end
        if(tasksfailed != 0) $display("%d tasks failed", tasksfailed); else $display("all tasks succeeded");
        $finish;
    end
    
endmodule

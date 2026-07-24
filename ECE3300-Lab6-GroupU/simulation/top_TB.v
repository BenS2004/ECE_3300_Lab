`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Robert Stevenson
// 
// Create Date: 07/23/2026 11:52:56 AM
// Design Name: 
// Module Name: top_TB
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


module top_TB(

    );
    
    reg clk, reset;
    reg[8:0] switches;
    wire [7:0] an, led;
    wire [6:0] seg;
    wire [31:0] counter;
    wire [3:0] bin_out;
    //switches 0-4 counter speed
    //switches 5-8 control {6:5} - alu add/sub, 7 - one's dir, 8 - ten's dir
    top_lab6 test_bench(.CLK(clk), .SW(switches),
        .BTNC(reset), .AN(an), .LED(led), .SEG(seg));
    clock_divider clk_div_tb(.clk(clk), .clk_div(counter));
    seg_to_bin seg_bin_tb(.seg(seg), .bin(bin_out));
    initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
    end
    
    integer i, j;
    
    initial begin
        reset = 0;
        switches = 9'b0;
        for(i = 0; i < 5; i=i+1) begin
        switches[4:0] = (5'b00001 << i);
            for(j = 0; j < 10; j = j+1) begin // count to ten
            while(counter[switches[4:0]] == 0)#5;
            while(counter[switches[4:0]] == 1)#5;
            end
            // change ctrl
            switches[8:7] = 2'b10; // tens count down
            for(j = 0; j < 10; j = j+1) begin // count to ten
            while(counter[switches[4:0]] == 0)#5;
            while(counter[switches[4:0]] == 1)#5;
            end
            switches[8:7] = 2'b01; //ones count down
            for(j = 0; j < 10; j = j+1) begin // count to ten
            while(counter[switches[4:0]] == 0)#5;
            while(counter[switches[4:0]] == 1)#5;
            end
            switches[8:7] = 2'b11; //ones and tens count down
            for(j = 0; j < 10; j = j+1) begin // count to ten
            while(counter[switches[4:0]] == 0)#5;
            while(counter[switches[4:0]] == 1)#5;
            end
            switches[6:5] = 2'b01; //bcd numbers subtract
            switches[8:7] = 2'b00; //ones and tens count up
        end
    end
    
endmodule

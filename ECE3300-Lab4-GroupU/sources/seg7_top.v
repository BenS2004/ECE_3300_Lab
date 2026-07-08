`timescale 1ns / 1ps


module seg7_top(
                    input clk,
                    input rst_n,
                    input [15:0] SW,
                    output wire [15:0] LED,
                    output wire [6:0] seg,
                    output wire dp,
                    output wire [7:0] an 
                );
                
                assign LED = SW;
                   
    seg7_driver top(
                        .clk(clk),
                        .rst_n(rst_n),
                        .SW({16'b0,SW}),
                        .Cnode(seg),
                        .dp(dp),
                        .AN(an)
                    );
                    
endmodule

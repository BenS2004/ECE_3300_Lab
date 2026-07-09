`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 07/07/2026 08:01:32 PM
// Design Name: Eight switching 7segs testbench
// Module Name: seg7_switching_tb
// Project Name: ECE3330_Lab4_GroupU
// Target Devices: Artyx 7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.01
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seg7_switching_tb(

                   );
                   
    reg clk_tb;
    reg rst_n_tb;
    reg [31:0] SW_tb;
    wire [6:0] Cnode_tb;
    wire dp_tb;
    wire [7:0] AN_tb;
                           
    seg7_driver mux_tb (
                        .clk(clk_tb),
                        .rst_n(rst_n_tb),
                        .SW(SW_tb),
                        .Cnode(Cnode_tb),
                        .dp(dp_tb),
                        .AN(AN_tb)
                       );       
                       
    initial
        begin
            clk_tb = 1'b0;
        end

    always
        begin
            #5 clk_tb = ~clk_tb;
        end
                                            
    initial
        begin
            rst_n_tb = 1'b0;
            SW_tb = 32'h0000_0000;
            
            #10;

            rst_n_tb = 1'b1;
            
            #12000000;
            $finish;   
        end            
                         
endmodule


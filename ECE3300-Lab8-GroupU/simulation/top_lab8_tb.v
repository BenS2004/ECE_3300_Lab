`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 08/04/2026 10:24:16 PM
// Design Name: Lab 8 Top Testbench (Micro-Lab F)
// Module Name: top_lab8_tb
// Project Name: ECE3300_Lab8_GroupU
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


module top_lab8_tb(

                  );
              
    reg clk_tb;
    reg btnc_tb;
    reg btnr_tb;
    reg [7:0] sw_tb;
    wire [3:0] led_tb;
    wire rgb_r_tb;
    wire rgb_g_tb;
    wire rgb_b_tb;           
                  
    top_lab8 dut(
                    .clk100mhz(clk_tb),
                    .btnc(btnc_tb),
                    .btnr(btnr_tb),
                    .sw(sw_tb),
                    .led(led_tb),
                    .rgb_r(rgb_r_tb), 
                    .rgb_g(rgb_g_tb), 
                    .rgb_b(rgb_b_tb)
                );    
            
    initial begin
        clk_tb = 1'b0;
        
        btnc_tb = 1'b0;
        btnr_tb = 1'b0;
        sw_tb = 7'd0;
    end       
    
    always #5 clk_tb = ~clk_tb;
    
    task advance(); 
        begin
            btnr_tb = 1'b1;
            #25_000_000;
            btnr_tb = 1'b0;    
            #25_000_000;
        end
    endtask
    
    initial begin
        @(posedge clk_tb) #1;
        btnc_tb = 1'b1;
        
        sw_tb = 8'd8;
        advance();
        
        sw_tb = 8'd128;
        advance();
        
        sw_tb = 8'd64;    
        advance();
        
        sw_tb = 8'd200; 
        advance();
        $finish;
    end               
                  
endmodule

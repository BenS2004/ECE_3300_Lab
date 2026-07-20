`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 07/16/2026 07:07:11 PM
// Design Name: lab5 top testbench
// Module Name: top_lab5_tb
// Project Name: ECE3300 Lab 5 Group U
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


module top_lab5_tb(

                  );
                  
    reg clk_tb;
    reg btnc_tb;
    reg btnu_tb;
    reg [4:0] sw_tb;

    wire [6:0] seg_tb;
    wire [7:0] an_tb;
    wire [12:0] led_tb;
    
    integer i;

    top_lab5 top_tb(
                        .CLK100MHZ(clk_tb),
                        .BTNC(btnc_tb),
                        .BTNU(btnu_tb),
                        .SW(sw_tb),
                        .seg(seg_tb),
                        .an(an_tb),
                        .LED(led_tb)
                   );   
                   
    initial
    begin
        clk_tb = 0;
    end

    always
    begin
        #5 clk_tb = ~clk_tb;
    end  
    
    initial
    begin
        btnc_tb = 0;
        btnu_tb = 0;
        sw_tb = 0;
        
        for(i = 0; i < 32; i = i + 1) begin     // Test LED[4:0] = SW
            sw_tb = i[4:0];
            #50;
            
            if(led_tb[4:0] !== sw_tb) begin
                $display("Fail: LED[4:0] != SW      LED = %b, SW = %b", led_tb, sw_tb);
                $fatal;
            end        
        end 
        
        $display("Passed LED test");
        
        btnc_tb = 1;
        #500;
        btnc_tb = 0;
        #5000000;
        
        $finish;  
    end
                     
endmodule

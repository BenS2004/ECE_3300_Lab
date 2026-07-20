`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles 
// 
// Create Date: 07/14/2026 10:40:41 PM
// Design Name: Clock divider testbench
// Module Name: clock_divider_tb
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


module clock_divider_tb (

                        );                     

    reg clk_tb;
    wire [31:0] clk_div_tb;

    integer i;
    integer count;  // Expected clk_div_tb count
    
    integer dn1, dn2; // delta nibble clk_div_tb[3:0], delta nibble clk_div_tb[7:4]
    integer clk_prev;   // clk_div_tb prev
    
    clock_divider dut (
                        .clk(clk_tb),
                        .clk_div(clk_div_tb)
                      );

    initial begin: Initialize
        clk_tb = 0;
        count = 0;
        dn1 = 0;
        dn2 = 0;
        clk_prev = 0;
    end

    always begin: Clock
        #5 clk_tb = ~clk_tb;
    end
    
    initial begin: Testbench
        #1        
        for(i = 0; i < 128; i = i + 1) begin
            clk_prev = clk_div_tb[7:0];         // Set prev
            
            @(posedge clk_tb)
            count = count + 1;                  // Update count after clk edge
            
            #1
            if(count !== clk_div_tb) begin      // Fail if count !== clk_div_tb
                $display("FAIL  CLK = %b, CLK_DIV = %b", count, clk_div_tb);
                $fatal;
            end
            
            if(clk_div_tb[3:0] != clk_prev[3:0])    // Track delta nibble 1
                dn1 = dn1 + 1;
                
            if(clk_div_tb[7:4] != clk_prev[7:4])    // Track detla nibble 2
                dn2 = dn2 + 1;
        end
        #5
        
        $display("PASS  delta n1 = %d, delta n2 = %d", dn1, dn2);   // Expect dn1 to change 16* faster than dn2
        $finish; 
    end
           
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles 
//
// Create Date: 07/19/2026 08:23:52 PM
// Design Name: bcd counter testbench
// Module Name: bcd_counter_tb
// Project Name: ECE3300 Lab 6 Group U
// Target Devices: Nexys a7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision: 0.02
// Revision 0.01 - File Created
// Revision 0.02 - Updated from lab 5
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bcd_counter_tb(

                     );
               
    reg clk_tb;
    reg rst_n_tb;
    reg dir_tb;
    wire [3:0] digit_tb;
        
    integer i;
    reg [3:0] expected;     // Expected digit value         
    
    bcd_counter digit_test(
                        .clk(clk_tb),
                        .rst_n(rst_n_tb),
                        .dir(dir_tb),
                        .digit(digit_tb)
                      );
                  
    initial begin
        clk_tb = 0;        
        rst_n_tb = 0;
        dir_tb = 1;
        expected = 0;
    end
    
    always begin
        #5 clk_tb = ~clk_tb;
    end
    
    initial begin
        @(posedge clk_tb);  // Let digit settle after reset
        #1;
        rst_n_tb = 1;
        #1;
        if(digit_tb !== 4'd0) begin     // Test 1: Reset test
            $display("Fail: digit failed to settle on reset         rst_n = %b, digit = %d", rst_n_tb, digit_tb);
            $fatal;
        end
        for(i = 0; i < 10; i = i + 1) begin  // Test 2: Incrementing
            @(posedge clk_tb);
            if(expected == 4'd9) begin  // Rollover control for expected value
                expected = 4'd0;
            end
            else begin
                expected = expected + 4'd1;
            end
            #1;
            if(digit_tb !== expected) begin  // Digit test
                $display("Fail: Digit did not increment properly        digit = %d, expected = %d", digit_tb, expected);
                $fatal;
            end
        end 

        expected = 4'd1;    // Account for extra up count before switching to down
        
        @(posedge clk_tb);
        #1;
        dir_tb = 0;
        for(i = 0; i < 12; i = i + 1) begin  // Test 3: Decrementing
            @(posedge clk_tb);
            if(expected == 4'd0) begin  // Rollover control for expected value
                expected = 4'd9;
            end
            else begin
                expected = expected - 4'd1;
            end
            #1;
            if(digit_tb !== expected) begin  // Digit test
                $display("Fail: Digit did not decrement properly        digit = %d, expected = %d", digit_tb, expected);
                $fatal;
            end
        end 

        @(posedge clk_tb);
        #1;
        rst_n_tb = 0;               // Test 5: Final reset test
        @(posedge clk_tb);
        #3;
        if(digit_tb !== 4'd0) begin            
            $display("Fail: Reset did not reset to zero     digit = %d, rst_n = %b", digit_tb, rst_n_tb);
            $fatal;
        end
        @(posedge clk_tb);
        $display("Passed all tests");
        $finish;        
    end  
                                  
endmodule
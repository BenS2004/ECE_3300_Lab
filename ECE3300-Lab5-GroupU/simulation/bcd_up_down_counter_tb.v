`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles 
// 
// Create Date: 07/16/2026 03:49:52 PM
// Design Name: bcd up down counter testbench
// Module Name: bcd_up_down_counter_tb
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


module bcd_up_down_counter_tb(

                             );
               
    reg clk_tb;
    reg rst_n_tb;
    reg dir_tb;
    wire [7:0] BCD_tb;
    
    
    integer i;
    integer expected;           // Expected decimal value
    
    reg [3:0] expected_tens;    // Expected tens value
    reg [3:0] expected_ones;    // Expected ones value
    
    reg [7:0] expected_bcd;     // Expected BCD value {tens, ones} 
    
    bcd_up_down_counter bcd_counter(
                                        .clk(clk_tb), 
                                        .rst_n(rst_n_tb),
                                        .dir(dir_tb),
                                        .BCD(BCD_tb)
                                   );
                  
    initial begin
        clk_tb = 0;
        rst_n_tb = 0;
        dir_tb = 1;
        expected = 0;
        expected_bcd = 8'h00;
    end
    
    always begin
        #5 clk_tb = ~clk_tb;
    end
    
    initial begin
        @(posedge clk_tb);  // Let BCD settle after reset
        #1;
        rst_n_tb = 1;
        #1;
        if(BCD_tb !== 8'h00) begin     // Test 1: Reset test
            $display("Fail: BCD failed to settle on reset         rst_n = %b, BCD = %h", rst_n_tb, BCD_tb);
            $fatal;
        end
        for(i = 0; i < 100; i = i + 1) begin  // Test 2: Incrementing
            @(posedge clk_tb);
            if(expected == 99) begin  // Rollover control for expected value
                expected = 0;
            end
            else begin
                expected = expected + 1;
            end
            
            expected_tens = expected / 10;
            expected_ones = expected % 10;
            expected_bcd = {expected_tens, expected_ones};
            
            #1;
            if(BCD_tb !== expected_bcd) begin 
                $display("Fail: BCD did not increment properly        BCD = %h, expected = %h", BCD_tb, expected_bcd);
                $fatal;
            end
        end 

        expected = 1;   // Account for extra up count before switching to down
        
        @(posedge clk_tb);
        #1;
        dir_tb = 0;
        for(i = 0; i < 105; i = i + 1) begin  // Test 3: Decrementing
            @(posedge clk_tb);
            if(expected == 0) begin  // Rollover control for expected value
                expected = 99;
            end
            else begin
                expected = expected - 1;
            end
            
            expected_tens = expected / 10;
            expected_ones = expected % 10;
            expected_bcd = {expected_tens, expected_ones};
            
            #1;
            if(BCD_tb !== expected_bcd) begin  
                $display("Fail: BCD did not decrement properly        BCD = %h, expected = %h", BCD_tb, expected_bcd);
                $fatal;
            end
        end 

        @(posedge clk_tb);
        #1;
        rst_n_tb = 0;           // Test 4: Final reset test
        @(posedge clk_tb);
        #1;
        if(BCD_tb !== 8'h00) begin            
            $display("Fail: Reset did not reset to zero     BCD = %h, rst_n = %b", BCD_tb, rst_n_tb);
            $fatal;
        end
        
        @(posedge clk_tb);
        $display("Passed all tests");
        $finish;        
    end  
                                  
endmodule


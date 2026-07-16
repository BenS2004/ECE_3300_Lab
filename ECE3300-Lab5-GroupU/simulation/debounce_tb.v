`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles & Robert Stevenson
// 
// Create Date: 07/2/2026 04:31:59 PM
// Design Name: Debounce testbed
// Module Name: debounce_tb
// Project Name: ECE 3300 Lab 5
// Target Devices: Nexys a7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Revosopm 0.02 - Updated from lab3
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module debounce_tb(

                  );
                  
    reg clk_tb;               
    reg btn_raw_tb;
    wire btn_clean_tb;
    
    debounce db_tb(
                    .clk(clk_tb), 
                    .btn_raw(btn_raw_tb),
                    .btn_clean(btn_clean_tb)
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
            btn_raw_tb = 1'b0;                // Test 1: Stable low     
            repeat(5) @(posedge clk_tb);
            #1;
            
            if(btn_clean_tb !== 1'b0)
            begin
                $display("FAIL: btn_clean should be 0 after stable low");
                $fatal;
            end     
                    
            btn_raw_tb = 1'b1;               // Test 2: Bounce  
            @(posedge clk_tb);
            #1;
            
            btn_raw_tb = 1'b0;  
            @(posedge clk_tb);
            #1;
            
            if(btn_clean_tb !== 1'b0)
            begin
                $display("FAIL: btn_clean changed after bounce");
                $fatal;
            end        
            
            btn_raw_tb = 1'b1;              // Test 3: Stable high
            repeat(5) @(posedge clk_tb);
            #1;   
            
            if(btn_clean_tb !== 1'b1)
            begin
                $display("FAIL: btn_clean should be 1 after stable high");
                $fatal;
            end
            
            btn_raw_tb = 1'b0;               // Test 4: Bounce  
            @(posedge clk_tb);
            #1;
            
            btn_raw_tb = 1'b1;  
            @(posedge clk_tb);
            #1;
            
            if(btn_clean_tb !== 1'b1)
            begin
                $display("FAIL: btn_clean changed after bounce");
                $fatal;
            end    
            
            btn_raw_tb = 1'b0;                // Test 5: Final stable low     
            repeat(5) @(posedge clk_tb);
            #1;
            
            if(btn_clean_tb !== 1'b0)
            begin
                $display("FAIL: btn_clean should be 0 after stable low");
                $fatal;
            end     
            
            $display("Passed all tests");
            $finish;
        end
endmodule
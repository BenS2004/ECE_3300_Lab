`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Ben Robles & Robert Stevenson
// Engineer: Cal Poly Pomona
// 
// Create Date: 07/30/2026 02:18:52 PM
// Design Name: Debounce & Toggle Testbench
// Module Name: debounce_toggle_tb
// Project Name: ECE3300_Lab7_GroupU
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



module debounce_toggle_tb(

                         );
                         
    reg clk_tb;               
    reg btn_raw_tb;
    reg rst_n_tb;
    wire btn_toggle_tb;
    
    debounce_toggle db_tb(
                    .clk_1kHz(clk_tb), 
                    .btn_raw(btn_raw_tb),
                    .rst_n(rst_n_tb),
                    .btn_toggle(btn_toggle_tb)
                  );
    
    initial 
        begin
            clk_tb = 1'b0;
            rst_n_tb = 1'b0;
        end
    
    always
        begin  
            #5 clk_tb = ~clk_tb;
         end
         
     initial
        begin
            @(posedge clk_tb)
            #1;
            rst_n_tb = 1'b1;
          
            btn_raw_tb = 1'b0;                // Test 1: Stable low     
            repeat(6) @(posedge clk_tb);
            #1;
            
            if(btn_toggle_tb !== 1'b0)
            begin
                $display("FAIL: btn_toggle should be 0 after stable low");
                $fatal;
            end     
                    
            btn_raw_tb = 1'b1;               // Test 2: Bounce  
            @(posedge clk_tb);
            #1;
            
            btn_raw_tb = 1'b0;  
            @(posedge clk_tb);
            #1;
            
            if(btn_toggle_tb !== 1'b0)
            begin
                $display("FAIL: btn_toggle changed after bounce");
                $fatal;
            end        
            
            btn_raw_tb = 1'b1;              // Test 3: Toggle on
            repeat(6) @(posedge clk_tb);
            #1;   
            btn_raw_tb = 1'b0;
            repeat(6) @(posedge clk_tb);
            
            if(btn_toggle_tb !== 1'b1)
            begin
                $display("FAIL: btn_toggle should be 1 after stable high");
                $fatal;
            end
            
            btn_raw_tb = 1'b1;               // Test 4: Bounce  
            @(posedge clk_tb);
            #1;
            
            btn_raw_tb = 1'b0;  
            @(posedge clk_tb);
            #1;
            
            if(btn_toggle_tb !== 1'b1)
            begin
                $display("FAIL: btn_toggle changed after bounce");
                $fatal;
            end    
            
            btn_raw_tb = 1'b1;              // Test 3: Toggle off
            repeat(6) @(posedge clk_tb);
            #1;   
            btn_raw_tb = 1'b0;
            repeat(6) @(posedge clk_tb);
            
            if(btn_toggle_tb !== 1'b0)
            begin
                $display("FAIL: btn_toggle should be 0 after stable high");
                $fatal;
            end     
            
            $display("Passed all tests");
            $finish;
        end


endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Ben Robles
// Engineer: Cal Poly Pomona
// 
// Create Date: 07/23/2026 09:14:53 PM
// Design Name: 8-bit alu
// Module Name: alu_tb
// Project Name: ECE 3300 Group U Lab 6
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


module alu_tb(

             );
         
    reg [3:0] a_tb;
    reg [3:0] b_tb;       
         
    reg [1:0] ctrl_tb;
    
    wire[7:0] result_tb;
  
    integer i, j;  
         
    alu alu_tb(
                    .a(a_tb),
                    .b(b_tb),
                    .ctrl(ctrl_tb),
                    .result(result_tb)
              );    
  
    initial
    begin
        a_tb = 4'd0;
        b_tb = 4'd0;
        ctrl_tb = 2'b00;
        
        #1;
        if(result_tb !== 8'd0) begin     // Test 1: Initialization
            $display("Fail: initialization test    a = %d, b = %b, result = %d", a_tb, b_tb, result_tb);
            $fatal;
        end
        for(i = 0; i < 16; i = i + 1) begin     // Test 2: Addition
            a_tb = i;
            for(j = 0; j < 16; j = j + 1) begin
                b_tb = j;
                #1;
                if(result_tb !== ({4'b0000, a_tb} + {4'b0000, b_tb})) begin
                    $display("Fail: addition test   a = %d, b = %d, result = %d", a_tb, b_tb, result_tb);
                    $fatal;
                end
            end
        end
        #1 ctrl_tb = 2'b01;                             // Test 3: Subtraction
                for(i = 0; i < 16; i = i + 1) begin     
            a_tb = i;
            for(j = 0; j < 16; j = j + 1) begin
                b_tb = j;
                #1;
                if(result_tb !== ({4'b0000, a_tb} - {4'b0000, b_tb})) begin
                    $display("Fail: subtraction test   a = %d, b = %d, result = %d", a_tb, b_tb, result_tb);
                    $fatal;
                end
            end
        end
        #1 ctrl_tb = 2'b10;         // Test 4: Default control test
        #1 if(result_tb !== 8'd0) begin     
                $display("Fail: default test    a = %d, b = %d, ctrl = %b, result = %d", a_tb, b_tb, ctrl_tb, result_tb);
                $fatal;
            end
            
        #1 ctrl_tb = 2'b00;
        a_tb = 4'd5;
            
        #1 ctrl_tb = 2'b11;        
        #1 if(result_tb !== 8'd0) begin     
                $display("Fail: default test    a = %d, b = %d, ctrl = %b, result = %d", a_tb, b_tb, ctrl_tb, result_tb);
                $fatal;
            end
            
        $display("Passed all tests");
        $finish;
    end          
                       
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Benjamin Robles
// 
// Create Date: 06/24/2026 03:10:37 PM
// Design Name: 4x16 decoder testbench
// Module Name: tb_decoder4x16
// Project Name: ECE3300_Lab2_GroupU
// Target Devices: Artix A7
// Tool Versions: Vivado 25.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_decoder4x16(

    );
    
    reg [3:0] A;
    reg E;
    
    wire [15:0] Y_gate;
    wire [15:0] Y_behav;
    
    reg[4:0] i;
    reg [4:0] j;
    
    integer count_gate;
    integer count_behav;
    
    decoder4x16_gate TB_GATE (
                                    .A(A),
                                    .E(E),
                                    .Y(Y_gate)
                                );
                                
    decoder4x16_behav TB_BEHAV  (
                                    .A(A),
                                    .E(E),
                                    .Y(Y_behav)
                                );
                             
   initial 
    begin
        E = 1'b1;
        $display("Decoder enabled");
        
        #10;
        
        for(i = 0; i < 16; i = i + 1)
            begin
            
                A = i;
                #10;
                
                count_gate = 0;
                count_behav = 0;
                
                for(j = 0; j < 16; j = j + 1)
                    begin
                        
                        if(Y_gate[j] == 1'b1) count_gate = count_gate + 1;      
                        if(Y_behav[j] == 1'b1) count_behav = count_behav + 1;
                      
                    end
                        
                if((count_gate!= 1) || (count_behav != 1))
                    begin
                        $display("FAIL: Output count != 1. E=%b A=%b Y_gate=%b Y_behav=%b", E, A, Y_gate, Y_behav);
                        $fatal;
                    end
                if((Y_gate[A] != 1'b1) || (Y_behav[A] != 1'b1))
                    begin
                        $display("FAIL: Incorrect output. E=%b A=%b Y_gate=%b Y_behav=%b", E, A, Y_gate, Y_behav);
                        $fatal;
                    end
                    
                $display("PASS: E=%b A=%b Y_gate=%b Y_behav=%b", E, A, Y_gate, Y_behav);
        
            end     
            
        E = 1'b0;
        $display("Decoder disabled");
        
        #10;
        
        for(i = 0; i < 16; i = i + 1)
            begin
            
                A = i;
                #10;
                
                count_gate = 0;
                count_behav = 0;
                
                for(j = 0; j < 16; j = j + 1)
                    begin
                        
                        if(Y_gate[j] == 1'b1) count_gate = count_gate + 1;      
                        if(Y_behav[j] == 1'b1) count_behav = count_behav + 1;
                      
                    end
                    
                if((count_gate!= 0) || (count_behav != 0))
                    begin
                        $display("Test Failed. Output high when disabled. E=%b A=%b Y_gate=%b Y_behav=%b", E, A, Y_gate, Y_behav);
                        $fatal;
                    end
                    
                $display("PASS: E=%b A=%b Y_gate=%b Y_behav=%b", E, A, Y_gate, Y_behav);
        
            end     
            
        $display("All Tests Passed.");
        $finish;
        
    end
    
endmodule
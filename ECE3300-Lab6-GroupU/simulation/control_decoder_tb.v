`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 07/23/2026 07:06:51 PM
// Design Name: control decoder testbench
// Module Name: control_decoder_tb
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


module control_decoder_tb(

                         );
                     
    reg [3:0] inp_tb;
    wire [3:0] ctrl_tb;         
    
    integer i;                
                         
    control_decoder ctrl_nibble_tb(
                                    .inp(inp_tb),
                                    .ctrl(ctrl_tb)
                                  );     
                              
    initial
    begin
        inp_tb = 4'd0;
        #1
        for(i = 0; i < 16; i = i + 1) begin
            inp_tb = i;
            #1;
            if(ctrl_tb != i) begin
                $display("FAIL: inp != op   inp = %b, ctrl = %b", inp_tb, ctrl_tb);
                $fatal;
            end
        end
        $display("Passed all tests");
        $finish;
    end
                                            
endmodule

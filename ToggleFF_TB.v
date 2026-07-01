`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/01/2026 11:35:27 AM
// Design Name: 
// Module Name: ToggleFF_TB
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ToggleFF_TB(
    );
    
    reg rst, btn_in;
    wire state;
    reg clk;
    
    toggle_switch toggle_TB(.btn_raw(btn_in), .clk(clk), 
            .rst(rst), .state(state));
    

    integer i, j;
    reg[2:0] serial_in;
    
    initial begin
        i <= 0;
        j <= 0;        
        serial_in = 3'b000;
        for(j=0; j<3; j=j+1)begin
            btn_in <= serial_in[j];
            clk <= 1;
            #10;
            clk <= 0;
            #10;
        end
        
        serial_in = 3'b111;
        for(i=0; i<3; i=i+1)begin
            for(j=0; j<3; j=j+1)begin
                btn_in <= serial_in[j];
                clk <= 1;
                #10;
                clk <= 0;
                #10;
            end               
        end
       
        for(i=0; i<8; i=i+1)begin
            serial_in <= i;
            for(j=0; j<3; j=j+1) begin
                btn_in <= serial_in[j];
                clk <= 1;
                #10;
                clk <= 0;
                #10;
            end
            btn_in <= 0;
            clk <= 1;
            #10;
            clk <= 0;
            #10;
        end
        
        clk <= 1;
        #10;
        clk <= 0;
        #10;
        clk <= 1;
        #10;
        clk <= 0;
        #10;
        
        for(i=7; i>=0; i=i-1)begin
            serial_in <= i;
            for(j=0; j<3; j=j+1)begin
                btn_in <= serial_in[j];
                clk <= 1;
                #10;
                clk <= 0;
                #10;
            end
            btn_in <= 0;
            clk <= 1;
            #10;
            clk <= 0;
            #10;
        end
        
        $finish;
    end
    
endmodule

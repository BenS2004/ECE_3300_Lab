`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2026 02:18:52 PM
// Design Name: 
// Module Name: debounce_toggle_tb
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


module debounce_toggle_tb(

    );
    
    reg raw_in, rst_n, clk;
    wire out;
    
    debounce_toggle TB(.btn_raw(raw_in), 
        .clk_1kHz(clk), .rst_n(rst), .btn_toggle(out));
    
    initial begin
        clk = 1;
        forever #5 clk = ~clk;       
    end
    
    
    
    reg[2:0] series_in, i;
    initial begin
        rst = 1;
        raw_in = 0;
        series_in = 3'b000;
        #10;
        rst = 0;
        repeat(8) begin
            for(i = 0; i < 3; i = i + 1)begin
                raw_in = series_in[i];
                #10;
                series_in = series_in + 1;
            end
        end
        rst = 1;
        #10;       
        series_in = 0;
            for(i = 0; i < 3; i = i + 1)begin
                raw_in = series_in[i];
                #10;
            end
        #10;
        series_in = 7;
            for(i = 0; i < 3; i = i + 1)begin
                raw_in = series_in[i];
                #10;
            end
        #10;
        series_in = 0;
        repeat(8) begin
            for(i = 0; i < 3; i = i + 1)begin
                raw_in = series_in[i];
                #10;
                series_in = series_in + 1;
            end
        end   
             
        $finish;
    end
    
endmodule

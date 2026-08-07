`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2026 02:53:58 PM
// Design Name: 
// Module Name: debounce_onepulse_tb
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


module debounce_onepulse_tb;

    reg clk, nrst, in;
    wire out;
    
    debounce_onepulse #(.STABLE_TICKS(20)) debounce_tb(
                                    .clk(clk), .rst_n(nrst), 
                                    .din(in), .pulse(out));
                                    
    initial begin        
        clk = 1;
        forever #5 clk = ~clk;
    end    
                                
    integer tasksfailed;
    initial begin
        tasksfailed = 0;
        nrst = 0;
        #10;
        in = 0;
        nrst = 1;
        repeat(7) #10 ;
        in = 1;
        repeat(6) #10;
        in = 0;
        repeat(7) #10;
        if (out != 0) tasksfailed = tasksfailed + 1;
        in = 1;
        repeat(21) #10;      
        in = 0;
        #10;            
        in = 1;               
        #20
        if (out != 1) tasksfailed = tasksfailed + 1;

        if(tasksfailed == 0) $display("All Tests Passed");
        else $display("%d Tests Failed", tasksfailed);
        
        $finish;
    end
    
    
endmodule

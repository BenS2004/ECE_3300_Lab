`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 03:01:02 PM
// Design Name: 
// Module Name: bcd_counter_alu_tb
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


module bcd_counter_alu_tb(

    );
    reg [3:0] ctrl;
    wire [3:0] tens, ones;
    reg rst, clk;
    wire [7:0] result;
    
    bcd_counter ones_counter(.digit(ones), .dir(ctrl[3]),
                    .rst_n(~rst), .clk(clk));
    bcd_counter tens_counter(.digit(tens), .dir(ctrl[2]),
                    .rst_n(~rst), .clk(clk));
    alu add_sub(.a({4'b0, ones}), .b({4'b0, tens}), 
                    .ctrl(ctrl[1:0]), .result(result));
    
    
    initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;  
    end
    
    integer i;
    initial begin
        ctrl = 4'b0;        
        rst = 1'b0;
        for(i = 0; i < 10; i=i+1)begin
            #10;
        end
       
        ctrl[3] = 1'b1; //tens count down
        rst = 1;
        #10;
        rst = 0;
        for(i = 0; i < 10; i=i+1)begin
            #10;
        end
        
        ctrl[3:2] = 2'b01; //oness count down
        rst = 1;
        #10;
        rst = 0;
        for(i = 0; i < 10; i=i+1)begin
            #10;
        end
        
        ctrl[3:2] = 2'b11; //tens and ones count down
        rst = 1;
        #10;
        rst = 0;
        for(i = 0; i < 10; i=i+1)begin
            #10;
        end
        
        ctrl[1:0] = 2'b01; // subtract tens and ones
        ctrl[3:2] = 2'b00; //tens and ones count up
        rst = 1;
        #10;
        rst = 0;
        for(i = 0; i < 10; i=i+1)begin
            #10;
        end
       
        ctrl[3] = 1'b1; //tens count down
        rst = 1;
        #10;
        rst = 0;
        for(i = 0; i < 10; i=i+1)begin
            #10;
        end
        
        ctrl[3:2] = 2'b01; //ones count down
        rst = 1;
        #10;
        rst = 0;
        for(i = 0; i < 10; i=i+1)begin
            #10;
        end
        
        ctrl[3:2] = 2'b11; //tens and ones count down
        rst = 1;
        #10;
        rst = 0;
        for(i = 0; i < 10; i=i+1)begin
            #10;
        end
        
        $finish;
    end
                                 
                endmodule

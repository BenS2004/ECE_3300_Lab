`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2026 03:18:11 PM
// Design Name: 
// Module Name: barrel_shifter16_TB
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


module barrel_shifter16_TB(

    );
    
    wire [15:0] result;
    reg [15:0] in_val;
    reg [3:0] shamt;
    reg dir, rot;
    
    barrel_shifter16 barrel_TB(.data_in(in_val), 
    .shamt(shamt), .dir(dir), .rot(rot), .data_out(result));
    
    integer i, j;
    initial begin
        in_val = 16'b0;
        shamt = 4'b0;
        i = 0;
        //Rotate Right
        dir = 1;
        rot = 1;        
        in_val = 16'hFAC3;        
        for(j = 0; j < 15; j = j + 1)begin
            shamt = j;
            #10;
        end
        
        //Rotate Left
        dir = 0;
        rot = 1;      
        in_val = 16'hFAC3;      
        for(j = 0; j < 15; j = j + 1)begin
            shamt = j;
            #10;
        end
     
        //Logical Shift Right
        dir = 1;
        rot = 0;
        //for(i = 0; i < 15; i = i + 1)begin
            in_val = 16'h8000;
            //in_val[i] = 1;
            for(j = 0; j < 15; j = j + 1)begin
                shamt = j;
                #10;
            end
        //end
        //Logical Shift Left
        dir = 0;
        rot = 0;
        //for(i = 0; i < 15; i = i + 1)begin
            in_val = 16'b1;
            //in_val[i] = 1;
            for(j = 0; j < 15; j = j + 1)begin
                shamt = j;
                #10;
            end
        //end
        $finish;
    end
    
endmodule

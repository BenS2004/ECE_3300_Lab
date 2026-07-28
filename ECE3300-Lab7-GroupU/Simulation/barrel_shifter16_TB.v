`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson
// 
// Create Date: 07/27/2026 03:18:11 PM
// Design Name: Barrel Shifter Test Bench
// Module Name: barrel_shifter16_TB
// Project Name: ECE 3300 Lab 7
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


module barrel_shifter16_TB(

    );
    
    wire [15:0] result;
    reg [15:0] check_val;
    reg [15:0] in_val;
    reg [3:0] shamt;
    reg dir, rot;
    
    barrel_shifter16 barrel_TB(.data_in(in_val), 
    .shamt(shamt), .dir(dir), .rot(rot), .data_out(result));
    
    integer i, j;
    initial begin
        in_val = 16'b0;
        shamt = 4'b0;
        check_val = 0;
        i = 0;
        //Rotate Right
        dir = 1;
        rot = 1;        
        in_val = 16'hFAC3;  
        check_val = {in_val[14:0], in_val[15]};      
        for(j = 0; j < 16; j = j + 1)begin  
            shamt = j; 
            check_val = {check_val[0], check_val[15:1]};
            #10;                 
            if(result != check_val) $display("Test Failed at %d", j);                       
        end
        
        //Rotate Left
        dir = 0;
        rot = 1;      
        in_val = 16'hFAC3; 
        check_val = {in_val[0], in_val[15:1]};     
        for(j = 0; j < 16; j = j + 1)begin            
            shamt = j;
            check_val = {check_val[14:0], check_val[15]};
            #10;            
            if(result != check_val) $display("Test Failed at %d", j);        
        end
     
        //Logical Shift Right
        dir = 1;
        rot = 0;        
        in_val = 16'h8000; 
        check_val = 16'h0001;    
        for(j = 0; j < 16; j = j + 1)begin
            shamt = j;
            check_val = {check_val[0], check_val[15:1]};
            #10;
            if(result != check_val) $display("Test Failed at %d", j);          
        end       
            
        //Logical Shift Left
        dir = 0;
        rot = 0;        
        in_val = 16'b1;
        check_val = 16'h8000;     
        for(j = 0; j < 16; j = j + 1)begin
            shamt = j; 
            check_val = {check_val[14:0], check_val[15]};          
            #10;            
            if(result != check_val) $display("Test Failed at %d", j);
        end 
        $finish;
    end
    
endmodule

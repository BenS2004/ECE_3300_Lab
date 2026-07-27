`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2026 12:49:10 PM
// Design Name: 
// Module Name: barrel_shifter16
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


module barrel_shifter16(
    input wire [15:0] data_in,
    input wire [3:0] shamt,
    input wire dir,
    input wire rot,
    output wire [15:0] data_out
    );
    //wire [15:0] rotr_val, rotl_val, logr_val, logl_val;
    wire [15:0] level0[0:15];
    wire [15:0] level1[0:7];
    wire [15:0] level2[0:3];
    wire [15:0] level3[0:1];
    wire [15:0] level4;
    
    genvar i;
//    generate
//        for(i = 0; i < 16; i = i + 1)begin
//             assign rotl_val[15:0] = {data_in[15-i:0], data_in[15:15-i]};   
//             assign rotr_val[15:0] = {data_in[0+i:0], data_in[15:0+i]};
//             assign logl_val[15:0] = data_in << i;
//             assign logr_val[15:0] = data_in >> i;
//             assign level0[i] = (rot&dir&rotr_val)|(rot&~dir&rotl_val)|(~rot&dir&logr_val)|(~rot&~dir&logl_val);    
//        end
        
//        for(i = 0; i < 7; i = i + 1)begin
//            Mux2x1 M1(.a(level0[2*i]), .b(level0[2*i+1]), 
//                .sel(shamt[0]), .y(level1[i]));
//        end
        
//        for(i = 0; i < 3; i = i + 1)begin
//            Mux2x1 M2(.a(level1[2*i]), .b(level1[2*i+1]),
//                .sel(shamt[1]), .y(level2[i]));          
//        end
        
//        for(i = 0; i < 1; i = i + 1)begin
//            Mux2x1 M3(.a(level2[2*i]), .b(level2[2*i+1]),
//                .sel(shamt[2]), .y(level3[i]));
//        end
        
//        Mux2x1 M4(.a(level3[0]), .b(level3[1]),
//            .sel(shamt[3]), .y(data_out));
        
//    endgenerate
    
    
    generate
        assign level0[0] = data_in;
        for(i = 1; i < 16; i = i + 1)begin
             //assign rotl_val[15:0] = {data_in[15-i:0], data_in[15:15-i]};   
             //assign rotr_val[15:0] = {data_in[0+i:0], data_in[15:0+i]};
             //assign logl_val[15:0] = data_in << i;
             //assign logr_val[15:0] = data_in >> i;
             //assign level0[i] = (rot&dir&rotr_val)|(rot&~dir&rotl_val)|(~rot&dir&logr_val)|(~rot&~dir&logl_val);
             assign level0[i] = (dir & {data_in[0+i-1:0], data_in[15:i]} ) | (~dir & {data_in[15-i:0], data_in[15: 15-i+1]});
               
        end
        
        for(i = 0; i < 7; i = i + 1)begin
            Mux2x1 #(.BUS_SIZE(16)) M1(.a(level0[2*i]), .b(level0[2*i+1]), 
                .sel(shamt[0]), .y(level1[i]));
        end
        
        for(i = 0; i < 3; i = i + 1)begin
            Mux2x1 #(.BUS_SIZE(16)) M2(.a(level1[2*i]), .b(level1[2*i+1]),
                .sel(shamt[1]), .y(level2[i]));          
        end
        
        for(i = 0; i < 1; i = i + 1)begin
            Mux2x1 #(.BUS_SIZE(16)) M3(.a(level2[2*i]), .b(level2[2*i+1]),
                .sel(shamt[2]), .y(level3[i]));
        end
        
        Mux2x1 #(.BUS_SIZE(16)) M4(.a(level3[0]), .b(level3[1]),
            .sel(shamt[3]), .y(level4));
            
        assign data_out = level0[shamt];
        //assign data_out = (level4 & rot) | (level4 & ~rot & ~dir & (16'hFFFF << shamt)) | (level4 & ~rot & dir & (16'hFFFF >> shamt));      
       endgenerate
    
endmodule

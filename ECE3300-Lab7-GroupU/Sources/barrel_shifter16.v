`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson
// 
// Create Date: 07/27/2026 12:49:10 PM
// Design Name: 16 Bit Barrel Shifter
// Module Name: barrel_shifter16
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


module barrel_shifter16(
    input wire [15:0] data_in,
    input wire [3:0] shamt,
    input wire dir,
    input wire rot,
    output wire [15:0] data_out
    );

    wire dir_not;
    assign dir_not = ~dir;
    wire [3:0] inv_shamt;
    assign inv_shamt = 16-shamt;
    wire [15:0] level0[0:15];
    wire [15:0] level1[0:7];
    wire [15:0] level2[0:3];
    wire [15:0] level3[0:1];
    wire [15:0] level4;
    
    wire [3:0] select;
    assign select = (shamt & {16{dir}}) | ({16{dir_not}} & ((16 - shamt)%16));
    
    genvar i;
        
    generate
        assign level0[0] = data_in;
        for(i = 1; i < 16; i = i + 1)begin             
             assign level0[i] = ({16{rot}}&({data_in[0+i-1:0], data_in[15:i]})) | ({16{~rot}}&{16{dir}} & (16'hffff >> i) & ({data_in[0+i-1:0], data_in[15:i]})) | ({16{~rot}}&{16{~dir}} & (16'hffff << (16 - i)) & ({data_in[0+i-1:0], data_in[15:i]}));
        end
        
        for(i = 0; i < 7; i = i + 1)begin
            Mux2x1 #(.BUS_SIZE(16)) M1(.a(level0[2*i]), .b(level0[2*i+1]), 
                .sel(select[0]), .y(level1[i]));
        end
        
        for(i = 0; i < 3; i = i + 1)begin
            Mux2x1 #(.BUS_SIZE(16)) M2(.a(level1[2*i]), .b(level1[2*i+1]),
                .sel(select[1]), .y(level2[i]));          
        end
        
        for(i = 0; i < 1; i = i + 1)begin
            Mux2x1 #(.BUS_SIZE(16)) M3(.a(level2[2*i]), .b(level2[2*i+1]),
                .sel(select[2]), .y(level3[i]));
        end
        
        Mux2x1 #(.BUS_SIZE(16)) M4(.a(level3[0]), .b(level3[1]),
            .sel(select[3]), .y(level4));
            
       assign data_out = level0[(select)];        
       endgenerate
    
endmodule

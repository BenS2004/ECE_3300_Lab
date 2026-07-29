`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson & Ben Robles
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
// Revision: 0.02
// Revision 0.01 - File Created
// Revision 0.02 - Updated
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module barrel_shifter16(
                            input [15:0] data_in,
                            input [3:0] shamt,
                            input dir,
                            input rotate,
                            output wire [15:0] data_out
                       );
                   
    reg [15:0] stage1_in;
    reg [15:0] stage2_in;
    reg [15:0] stage3_in;
    reg [15:0] stage4_in;
    
    wire [15:0] stage0;
    wire [15:0] stage1_out;
    wire [15:0] stage2_out;
    wire [15:0] stage3_out;
    wire [15:0] stage4_out;
    
    genvar i;
    
    assign stage0 = data_in;
    
    always @(*)
    begin
        case ({rotate, dir})
            2'b00: begin    // Shift left
                stage1_in = {stage0[14:0], 1'b0};     
                stage2_in = {stage1_out[13:0], 2'b00};     
                stage3_in = {stage2_out[11:0], 4'b0000};    
                stage4_in = {stage3_out[7:0], 8'b00000000};   
            end
            2'b01: begin    // Shift right
                stage1_in = {1'b0, stage0[15:1]}; 
                stage2_in = {2'b00, stage1_out[15:2]};     
                stage3_in = {4'b0000, stage2_out[15:4]};    
                stage4_in = {8'b00000000, stage3_out[15:8]};
            end
            2'b10: begin    // Rotate left
                stage1_in = {stage0[14:0], stage0[15]}; 
                stage2_in = {stage1_out[13:0], stage1_out[15:14]};      
                stage3_in = {stage2_out[11:0], stage2_out[15:12]};     
                stage4_in = {stage3_out[7:0], stage3_out[15:8]}; 
            end 
            2'b11: begin    // Rotate right
                stage1_in = {stage0[0], stage0[15:1]}; 
                stage2_in = {stage1_out[1:0], stage1_out[15:2]};      
                stage3_in = {stage2_out[3:0], stage2_out[15:4]};     
                stage4_in = {stage3_out[7:0], stage3_out[15:8]};     
            end
        endcase
    end
    
    generate
        for (i = 0; i < 16; i = i + 1) begin
            mux2x1 mux_stage1(
                                .a(stage0[i]),
                                .b(stage1_in[i]),
                                .sel(shamt[0]),
                                .y(stage1_out[i])
                             );
        end
        
        for (i = 0; i < 16; i = i + 1) begin
            mux2x1 mux_stage2(
                                .a(stage1_out[i]),
                                .b(stage2_in[i]),
                                .sel(shamt[1]),
                                .y(stage2_out[i])
                             );
        end
        
        for (i = 0; i < 16; i = i + 1) begin
            mux2x1 mux_stage3(
                                .a(stage2_out[i]),
                                .b(stage3_in[i]),
                                .sel(shamt[2]),
                                .y(stage3_out[i])
                             );
        end
        
        for (i = 0; i < 16; i = i + 1) begin
            mux2x1 mux_stage4(
                                .a(stage3_out[i]),
                                .b(stage4_in[i]),
                                .sel(shamt[3]),
                                .y(stage4_out[i])
                             );
        end         
    endgenerate
                     
    assign data_out = stage4_out;                     
                       
endmodule

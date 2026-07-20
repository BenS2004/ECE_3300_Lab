`timescale 1ns / 1ps

module mux32x1(
                input wire [31:0] in,
                input wire [4:0] sel,
                output wire out
              );

    wire [15:0] level1;
    wire [7:0] level2;
    wire [3:0] level3;
    wire [1:0] level4;
    
    genvar i;
    generate
        for(i=0; i<16; i=i+1)begin
            mux2x1 M1(.a(in[i*2]), .b(in[i*2+1]), .sel(sel[0]), .y(level1[i]));
        end
        for(i=0; i<8; i=i+1)begin
            mux2x1 M2(.a(level1[2*i]), .b(level1[2*i+1]), .sel(sel[1]), .y(level2[i]));
        end
        for(i=0; i<4; i=i+1)begin
            mux2x1 M3(.a(level2[2*i]), .b(level2[2*i+1]), .sel(sel[2]), .y(level3[i]));
        end
        for(i=0; i<2; i=i+1)begin
            mux2x1 M4(.a(level3[2*i]), .b(level3[2*i+1]), .sel(sel[3]), .y(level4[i]));
        end
        mux2x1 M5(.a(level4[0]), .b(level4[1]), .sel(sel[4]), .y(out));
    endgenerate
endmodule
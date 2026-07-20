`timescale 1ns / 1ps

module mux2x1(
                input wire sel,
                input wire a,
                input wire b,
                output wire y
             );
    
    wire selnot;
    assign selnot = ~sel;
    assign y = (a & selnot) | (b & sel);
    
endmodule

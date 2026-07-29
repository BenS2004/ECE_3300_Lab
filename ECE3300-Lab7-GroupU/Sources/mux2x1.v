`timescale 1ns / 1ps


module mux2x1(
                input a,
                input b,
                input sel,
                output wire y
             );

    assign y = (~sel & a) | (sel & b);

endmodule
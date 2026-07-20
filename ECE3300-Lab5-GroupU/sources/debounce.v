`timescale 1ns / 1ps

module debounce(
                    input wire clk,
                    input wire btn_raw,
                    output reg btn_clean
               );
    
    reg[2:0] state;
    initial state = 3'b000;
    
    always @(posedge clk)begin
        state = {state[1:0], btn_raw};
        if(state == 3'b000) btn_clean = 0;
        else if (state == 3'b111) btn_clean = 1;
    end
endmodule
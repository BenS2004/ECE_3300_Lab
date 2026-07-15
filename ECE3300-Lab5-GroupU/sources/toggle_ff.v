`timescale 1ns / 1ps

module toggle_ff (
                        input clk,
                        input rst_n,
                        input btn_raw,
                        output reg state
                     );
    wire btn_clean;
    reg btn_prev;
    
    debounce db (.clk(clk), .btn_raw(btn_raw), .btn_clean(btn_clean));
    
    always @(posedge clk) begin
        if (!rst_n) begin
            state <= 1;
            btn_prev <= 0;
        end 
        else begin
            if (btn_clean && !btn_prev)
            state <= ~state;
            btn_prev <= btn_clean;
        end
    end
endmodule

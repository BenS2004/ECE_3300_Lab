module mux16x1_tb(

                 );

    reg [15:0] in;
    reg [3:0] sel;
    wire out;
    
    integer i, j;
    
      mux16x1 mx16_tb(.in(in), .sel(sel), .out(out));
    
    initial begin
        in <= 16'd0;
        sel <= 4'd0;
        for(i=0; i<16; i=i+1)begin
            sel <= i;
            for(j=0; j<16; j=j+1)begin
                in[j] = 1;
                #10;
                in[j] = 0;
                #10;
            end
        end
        $finish;
    end
endmodule

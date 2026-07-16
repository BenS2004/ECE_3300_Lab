`timescale 1ns / 1ps

module mux2x1_tb(

                );
    
    reg a, b, sel;
    wire y;
    reg [1:0] inval; 
    integer i, j;
    
    mux2x1 mx_tb(.a(a), .b(b), .sel(sel), .y(y));
    
    initial begin     
        inval = 2'b00;
        a = 0;
        b = 0;
        sel = 0;
        for(i=0; i<2; i=i+1)begin
            sel = i;            
            for(j=0; j<4; j=j+1)begin
                inval = j;
                a = inval[0];
                b = inval[1];
                #10;
            end
        end
        $finish;
    end
endmodule


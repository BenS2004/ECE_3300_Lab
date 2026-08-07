`timescale 1ns/1ps

module load_fsm_tb;
    
    reg clk, nrst, load;
    wire [1:0] slot;
    wire [3:0] slot_hot;
    wire res, red, green, blue;
    
    load_fsm fsm_tb(.clk(clk), .rst_n(nrst), .load_pulse(load), 
                    .slot(slot), .slot_onehot(slot_hot), .wr_res(res), 
                    .wr_r(red), .wr_g(green), .wr_b(blue));
    
    initial begin
        clk = 1;
        forever #5 clk = ~clk;      
    end
    integer i, tasksfailed;
    initial begin
        tasksfailed = 0;
        load = 0;
        nrst = 0;
        #20;
        nrst = 1;
        #20;
        for(i = 1; i <= 8; i=i+1) begin
            load = 1;
            #10;
            load = 0;
            #10;
            if(slot_hot != 4'b1 << (i % 4)) tasksfailed = tasksfailed + 1;
        end
        if(tasksfailed == 0) $display("All Tests Passed");
        else $display("%d Tests Failed", tasksfailed);
    $finish;
    end
    
endmodule
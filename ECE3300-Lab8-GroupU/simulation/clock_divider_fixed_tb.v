`timescale 1ns/1ps


module clock_divider_fixed_tb;
    
    reg clk_10MHz, nrst, clk_check, pwm_check;
    wire clk_out, pwm_out;
    clock_divider_fixed #( .INPUT_HZ(100_000_000), 
                        .TICK1_HZ(1_000),
                        .PWM_HZ(20_000) ) clock_divider_tb(
                            .clk_in(clk_10MHz), .rst_n(nrst), 
                            .clk_1k(clk_out), .clk_pwm(pwm_out)
                        );
                        
    
                        
    initial begin 
        nrst = 1;
        clk_10MHz = 1;
        forever #5 clk_10MHz = ~clk_10MHz;
    end              
    integer tasksfailed;
    initial begin 
        tasksfailed = 0;            
        nrst = 0;
        clk_check = 0;
        pwm_check = 0;
        #5;
        nrst = 1;
        clk_check = clk_out;
        repeat(6) begin
            #500_000 clk_check = ~clk_check;
            if(clk_out != clk_check) tasksfailed = tasksfailed + 1;
        end
        
        nrst = 0;
        #5;
        nrst = 1;
        pwm_check = pwm_out;
        repeat(6) begin
            #25_000 pwm_check = ~pwm_check;
            if(pwm_out != pwm_check) tasksfailed = tasksfailed + 1;
        end
        
        if(tasksfailed == 0) $display("All Tests Passed");
        else $display("%d Tests Failed", tasksfailed);
        
        $finish;
    end
          
endmodule
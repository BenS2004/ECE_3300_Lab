`timescale 1ns/1ps

module rgd_led_driver_tb;
    reg[2:0] pwm;
    wire[2:0] led;   
    
    rgb_led_driver#(.ACTIVE_LOW(1)) rgb_tb_one(
                    .pwm_r(pwm[2]), .pwm_g(pwm[1]), .pwm_b(pwm[0]),
                    .led_r(led[2]), .led_g(led[1]), .led_b(led[0]));
    
    reg [2:0] pwm2;
    wire[2:0] led2;
    
    rgb_led_driver#(.ACTIVE_LOW(0)) rgb_tb_two(
                    .pwm_r(pwm2[2]), .pwm_g(pwm2[1]), .pwm_b(pwm2[0]),
                    .led_r(led2[2]), .led_g(led2[1]), .led_b(led2[0]));
    
    integer i, tasksfailed;
    
    initial begin 
        tasksfailed = 0;
        pwm = 0; 
        pwm2 = 0;
        for(i = 0; i < 8; i = i + 1) begin
            pwm = i;
            #10;
            if(led != ~pwm) tasksfailed = tasksfailed + 1;
            #10;
        end
        
        for(i = 0; i < 8; i = i + 1) begin
            pwm2 = i;
            #10;
            if(led2 != pwm2) tasksfailed = tasksfailed + 1;
            #10;
        end
        
        if(tasksfailed == 0) $display("All Tests Passed");
        else $display("%d Tests Failed", tasksfailed);
        
        $finish;
        
    end
    
endmodule
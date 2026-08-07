`timescale 1ns/1ps

module top_lab8(
                    input wire clk100mhz,
                    input wire btnc,
                    input wire btnr,
                    input wire [7:0] sw,
                    output wire [3:0] led,
                    output wire rgb_r, rgb_g, rgb_b
               );
               
    wire rst_n = ~btnc;
    wire clk_1k, clk_pwm;
    
    clock_divider_fixed u_div(
                                .clk_in(clk100mhz), 
                                .rst_n(rst_n), 
                                .clk_1k(clk_1k),
                                .clk_pwm(clk_pwm)
                             );
    wire load_pulse;
    
    debounce_onepulse #(.STABLE_TICKS(20)) u_db(
                                                    .clk(clk_1k), 
                                                    .rst_n(rst_n), 
                                                    .din(btnr),
                                                    .pulse(load_pulse)
                                               );
                                               
    wire [1:0] slot;
    wire [3:0] slot_oh;
    wire wr_res, wr_r, wr_g, wr_b;
    
    load_fsm u_fsm(
                        .clk(clk_1k),
                        .rst_n(rst_n), 
                        .load_pulse(load_pulse),
                        .slot(slot), 
                        .slot_onehot(slot_oh),
                        .wr_res(wr_res), 
                        .wr_r(wr_r),
                        .wr_g(wr_g),
                        .wr_b(wr_b)
                  );
                  
    assign led = slot_oh;
    reg [7:0] reg_res, reg_r, reg_g, reg_b;
    
    always @(posedge clk_1k or negedge rst_n) begin
        if (!rst_n) begin reg_res<=8'd63; reg_r<=0; reg_g<=0; reg_b<=0; end
        else begin
            if (wr_res) reg_res <= sw;
            if (wr_r) reg_r <= sw;
            if (wr_g) reg_g <= sw;
            if (wr_b) reg_b <= sw;
        end
    end
    
    reg [7:0] res_q1,res_q2,r_q1,r_q2,g_q1,g_q2,b_q1,b_q2;
    
    always @(posedge clk_pwm or negedge rst_n) begin
        if (!rst_n) begin res_q1<=0; res_q2<=0; r_q1<=0; r_q2<=0; g_q1<=0;
        g_q2<=0; b_q1<=0; b_q2<=0; end
        else begin
            res_q1<=reg_res; res_q2<=res_q1;
            r_q1<=reg_r; r_q2<=r_q1; g_q1<=reg_g; g_q2<=g_q1; b_q1<=reg_b;
            b_q2<=b_q1;
        end
    end
    
    wire pwm_r, pwm_g, pwm_b;
    
    pwm_core u_pwm(
                        .clk(clk_pwm), 
                        .rst_n(rst_n),
                        .period(res_q2), 
                        .duty_r(r_q2), 
                        .duty_g(g_q2), 
                        .duty_b(b_q2),
                        .pwm_r(pwm_r),
                        .pwm_g(pwm_g),
                        .pwm_b(pwm_b)
                );
      
    rgb_led_driver #(.ACTIVE_LOW(0)) u_led
                    (
                        .pwm_r(pwm_r),
                        .pwm_g(pwm_g),
                        .pwm_b(pwm_b),
                        .led_r(rgb_r),
                        .led_g(rgb_g), 
                        .led_b(rgb_b)
                    );
    
endmodule`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Ben Robles
// 
// Create Date: 08/04/2026 10:24:16 PM
// Design Name: Lab 8 Top Testbench (Micro-Lab F)
// Module Name: top_lab8_tb
// Project Name: ECE3300_Lab8_GroupU
// Target Devices: Nexys a7
// Tool Versions: Vivado 2025.2
// Description: 
// 
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_lab8_tb(

                  );
              
    reg clk_tb;
    reg btnc_tb;
    reg btnr_tb;
    reg [7:0] sw_tb;
    wire [3:0] led_tb;
    wire rgb_r_tb;
    wire rgb_g_tb;
    wire rgb_b_tb;           
                  
    top_lab8 dut(
                    .clk100mhz(clk_tb),
                    .btnc(btnc_tb),
                    .btnr(btnr_tb),
                    .sw(sw_tb),
                    .led(led_tb),
                    .rgb_r(rgb_r_tb), 
                    .rgb_g(rgb_g_tb), 
                    .rgb_b(rgb_b_tb)
                );    
            
    initial begin
        clk_tb = 1'b0;
        
        btnc_tb = 1'b0;
        btnr_tb = 1'b0;
        sw_tb = 7'd0;
    end       
    
    always #5 clk_tb = ~clk_tb;
    
    task advance(); 
        begin
            btnr_tb = 1'b1;
            #25_000_000;
            btnr_tb = 1'b0;    
            #25_000_000;
        end
    endtask
    
    initial begin
        @(posedge clk_tb) #1;
        btnc_tb = 1'b1;
        
        sw_tb = 8'd8;
        advance();
        
        sw_tb = 8'd128;
        advance();
        
        sw_tb = 8'd64;    
        advance();
        
        sw_tb = 8'd200; 
        advance();
        $finish;
    end               
                  
endmodule

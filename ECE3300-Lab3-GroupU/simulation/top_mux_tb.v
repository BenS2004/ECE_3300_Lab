`timescale 1ns / 1ps

module top_mux_tb(

                 );

    reg clk_tb;
    reg rst_tb;
    reg [15:0] sw_tb;
    
    reg btnU_tb;
    reg btnD_tb;
    reg btnL_tb;
    reg btnR_tb;
    
    wire led0_tb;

    integer i;

    top_mux_lab3 top_tb(
                            .clk(clk_tb),
                            .rst(rst_tb),
                            .SW(sw_tb),
                            .btnU(btnU_tb),
                            .btnD(btnD_tb),
                            .btnL(btnL_tb),
                            .btnR(btnR_tb),
                            .LED0(led0_tb)
                       );

    initial
        begin
            clk_tb = 1'b0;
        end

    always
        begin
            #5 clk_tb = ~clk_tb;
        end

    initial
            begin
                rst_tb = 1'b1;
                sw_tb = 16'b0000_0000_0000_0000;
                btnU_tb = 1'b0;
                btnD_tb = 1'b0;
                btnL_tb = 1'b0;
                btnR_tb = 1'b0;

                @(negedge clk_tb);
                rst_tb = 1'b0;
		        sw_tb = 16'b0000_0000_0000_0001;

                @(negedge clk_tb);
                if(led0_tb !== 1'b1)
                    begin
                        $display("FAILED DEFAULT TEST");
                        $fatal;
                    end
                else
                    begin
                        $display("PASSED DEFAULT TEST");
                    end                    
                    
                @(negedge clk_tb);
                sw_tb = 16'b0000_0000_0000_0010;
                btnD_tb = 1'b1;
                
                for(i = 0; i < 6; i = i + 1)
                    begin
                        @(posedge clk_tb);
                    end
                    
                if(led0_tb !== 1'b1)
                    begin
                        $display("FAILED BTN D TEST");
                        $fatal;
                    end
                else
                    begin
                        $display("PASSED BTN D TEST");
                    end
                    
                @(negedge clk_tb);
                sw_tb = 16'b0000_0000_0000_1000;
                btnR_tb = 1'b1;
                
                for(i = 0; i < 6; i = i + 1)
                    begin
                        @(posedge clk_tb);
                    end
                    
                if(led0_tb !== 1'b1)
                    begin
                        $display("FAILED BTN D + BTN R TEST");
                        $fatal;
                    end
                else
                    begin
                        $display("PASSED BTN D + BTN R TEST");
                    end
                    
                @(negedge clk_tb);
                sw_tb = 16'b0000_0000_1000_0000;
                btnL_tb = 1'b1;
                
                for(i = 0; i < 6; i = i + 1)
                    begin
                        @(posedge clk_tb);
                    end
                    
                if(led0_tb !== 1'b1)
                    begin
                        $display("FAILED BTN D + BTN R + BTN L TEST");
                        $fatal;
                    end
                else
                    begin
                        $display("PASSED BTN D + BTN R + BTN L TEST");
                    end
                    
                @(negedge clk_tb);
                sw_tb = 16'b1000_0000_0000_0000;
                btnU_tb = 1'b1;
                
                for(i = 0; i < 6; i = i + 1)
                    begin
                        @(posedge clk_tb);
                    end
                    
                if(led0_tb !== 1'b1)
                    begin
                        $display("FAILED BTN D + BTN R + BTN L + BTN U TEST");
                        $fatal;
                    end
                else
                    begin
                        $display("PASSED BTN D + BTN R + BTN L + BTN U TEST");
                    end
                    
                @(negedge clk_tb);
                rst_tb = 1'b1;
                                
                for(i = 0; i < 3; i = i + 1)
                    begin
                        @(posedge clk_tb);
                    end
                    
                if(led0_tb !== 1'b0)
                    begin
                        $display("FAILED RESET TEST");
                        $fatal;
                    end
                else
                    begin
                        $display("PASSED RESET TEST");
                    end
                    
                $display("ALL TESTS PASSED");
                $finish;
            end           
endmodule
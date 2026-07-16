`timescale 1ns / 1ps

module toggle_switch_tb(

                        );

    reg clk_tb;
    reg rst_tb;
    reg btn_raw_tb;
    wire state_tb;

    integer i;

    toggle_switch ts_tb(
                            .clk(clk_tb),
                            .rst(rst_tb),
                            .btn_raw(btn_raw_tb),
                            .state(state_tb)
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
                btn_raw_tb = 1'b0;
                
                for(i = 0; i < 3; i = i + 1)
                    begin
                        @(posedge clk_tb);
                    end

                @(negedge clk_tb);
                rst_tb = 1'b0;
                btn_raw_tb = 1'b1;
                
                
                for(i = 0; i < 6; i = i + 1)
                    begin
                        @(posedge clk_tb);
                    end
                    
                    @(negedge clk_tb);
                
                if(state_tb !== 1'b1)
                    begin
                        $display("FAILED TO TOGGLE");
                        $fatal;
                    end
                else
                    begin
                        $display("PASSED TEST TOGGLE");
                    end
                    
                @(negedge clk_tb);
                rst_tb = 1'b1;
                btn_raw_tb = 1'b0;
                    
                @(negedge clk_tb);
                if(state_tb !== 1'b0)
                    begin
                        $display("FAILED TO RESET");
                        $fatal;
                    end
                else
                    begin
                        $display("PASSED TEST RESET");
                    end
               $finish;
            end                             
endmodule
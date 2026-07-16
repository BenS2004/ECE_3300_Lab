`timescale 1ns / 1ps

module debounce_tb(

                  );
                  
    reg clk_tb;               
    reg btn_in_tb;
    wire btn_out_tb;

    integer i;
    
    debounce db_tb(
                    .clk(clk_tb), 
                    .btn_in(btn_in_tb),
                    .btn_clean(btn_out_tb)
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
            btn_in_tb = 1'b0;
            
            for(i = 0; i < 4; i = i + 1)
                begin
                    @(posedge clk_tb);
                end
                
            @(negedge clk_tb);
            
            if(btn_out_tb !== 1'b0)
                begin
                    $display("FAILED INITIAL STATE TEST");
                    $fatal;
                end
            else
                begin
                    $display("PASSED INITIAL STATE TEST");
                end 
                            
            for(i = 0; i < 4; i = i + 1)
                begin
                    @(negedge clk_tb)
                        begin
                            btn_in_tb = ~btn_in_tb;
                        end
                        
                    @(posedge clk_tb)
                        begin
                            #1;     
                            if(btn_out_tb !== 1'b0)
                                begin
                                    $display("FAILED DEBOUNCE TEST");
                                    $fatal;
                                end
                        end
                end
                
            $display("PASSED DEBOUNCE TEST");
            
            @(negedge clk_tb);
            
            btn_in_tb = 1'b1;
            
            for(i = 0; i < 4; i = i + 1)
                begin
                    @(posedge clk_tb);
                end
                
            @(negedge clk_tb);
                
            if(btn_out_tb !== 1'b1)
                begin
                    $display("FAILED OUTPUT HIGH TEST");
                    $fatal;
                end
           else
                begin
                    $display("PASSED OUTPUT HIGH TEST");
                end
                
            @(negedge clk_tb);
            
            btn_in_tb = 1'b0;
            
             for(i = 0; i < 4; i = i + 1)
                begin
                    @(posedge clk_tb);
                end
                
            @(negedge clk_tb);
                
            if(btn_out_tb !== 1'b0)
                begin
                    $display("FAILED OUTPUT LOW TEST");
                    $fatal;
                end
            else
                begin
                    $display("PASSED OUTPUT LOW TEST");
                    @(negedge clk_tb);
                end
            $finish;
        end
endmodule
/////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly Pomona
// Engineer: Robert Stevenson
// 
// Create Date: 06/19/2026 08:30:58 PM
// Design Name: Four to Sixteen Decoder
// Module Name: 4-16_decoder
// Project Name: ECE 3250 Lab 2
// Target Devices: Nexys A7
// Tool Versions: Vivado 25.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module four_to_sixteen_decoder_behave(
    input wire [3:0] code, input wire enable,
    output wire [15:0] dest
        );
    
   reg [15:0]destin;
   integer i;
   always @(*) begin
        destin = 16'b0;
        if(enable)begin
            for(i = 0; i < 16; i = i + 1)begin
                destin[i] = (code == i);
            end
        end
   end
   assign dest = destin;
   endmodule

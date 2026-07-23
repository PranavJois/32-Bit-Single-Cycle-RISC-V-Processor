module program_counter(clk,rst,PC,PC_next);

input clk,rst;
input [31:0] PC_next;
output reg [31:0] PC;

always@(posedge clk)
begin
    if(~rst)
        PC <= 32'd0;
    else 
        PC <= PC_next;
end
endmodule

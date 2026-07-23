module data_memory(A,RD,WD,clk,WE);
input WE,clk;
output [31:0] RD;
input [31:0] A,WD;

reg [31:0] data_mem [1023:0];

assign RD = data_mem[A[31:2]];

always@(posedge clk)
begin
    if(WE)
        data_mem[A[31:2]] <= WD;
end

initial begin
    data_mem[5] = 32'h00000006;
    data_mem[7] = 32'h00000039;
end

endmodule

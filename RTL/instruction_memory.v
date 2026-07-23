module instruction_memory(A,RD,rst);

input [31:0] A;
output [31:0] RD;
input rst;

reg [31:0] mem [1023:0];

assign RD = (rst) ? mem[A[31:2]] : 32'd0;

initial begin
    mem[0] = 32'hFFC4A303;
    mem[1] = 32'h00832383;
end

endmodule

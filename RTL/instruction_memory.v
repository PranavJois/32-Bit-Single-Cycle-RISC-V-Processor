module instruction_memory(A,RD);
input [31:0] A;
output [31:0] RD;

reg [31:0] mem [1023:0];

assign RD = mem[A[31:2]];

initial begin
    mem[0] = 32'hFFC4A303;
    mem[1] = 32'h00832383;
end


endmodule

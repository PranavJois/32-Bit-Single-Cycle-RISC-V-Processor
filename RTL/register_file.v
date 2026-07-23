module register_file(A1,A2,RD1,RD2,A3,WD3,WE3,clk);

input [4:0] A1,A2,A3;
input clk,WE3;
input [31:0] WD3;
output [31:0] RD1,RD2;

reg [31:0] register [31:0];

assign RD1 = (A1!=5'd0) ? register[A1] : 32'd0;
assign RD2 = (A2!=5'd0) ? register[A2] : 32'd0;

always@(posedge clk)
begin
    if(WE3 && (A3 != 5'd0))
        register[A3] <= WD3;
end

initial begin
    register[0] = 32'd0;
    register[4] = 32'h00000002;
    register[5] = 32'h00000023;
end

endmodule

module single_cycle_top_tb();
reg clk = 1'b1, rst;

single_cycle_top single_cycle_top(.clk(clk),.rst(rst));

initial begin
    $dumpfile("Single_Cycle.vcd");
    $dumpvars(0);
end

always begin
    clk = ~clk;
    #50;
end

initial begin
    rst <= 1'b0;
    #150;

    rst <= 1'b1;
    #450;
    $finish;
end

endmodule

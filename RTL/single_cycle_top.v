`include "alu.v"
`include "control_unit_top.v"
`include "data_memory.v"
`include "instruction_memory.v"
`include "mux_2x1.v"
`include "pc_adder.v"
`include "program_counter.v"
`include "register_file.v"
`include "sign_extend.v"


module single_cycle_top(clk,rst);

input clk,rst;

wire RegWrite, MemWrite, ALUSrc, ResultSrc, zero;
wire [31:0] PC, pc_plus_4, RD_instr, imm_ext, RD1, RD2, ALUResult, src_B, Read_data, Result;
wire [1:0] imm_src;
wire [2:0] ALUControl;

instruction_memory instruction_memory(.A(PC),
                                      .RD(RD_instr));

program_counter program_counter(.clk(clk),
                                .rst(rst),
                                .PC(PC),
                                .PC_next(pc_plus_4));

pc_adder pc_adder(.A(PC),
                  .B(32'd4),
                  .C(pc_plus_4));

alu alu(.A(RD1),
        .B(src_B),
        .ALUControl(ALUControl),
        .Result(ALUResult),
        .Z(zero),
        .N(),
        .V(),
        .C());

control_unit_top control_unit_top(.Z(zero),
                                  .opcode(RD_instr[6:0]),
                                  .PCSrc(),
                                  .ResultSrc(ResultSrc),
                                  .MemWrite(MemWrite),
                                  .ALUSrc(ALUSrc),
                                  .ImmSrc(imm_src),
                                  .RegWrite(RegWrite),
                                  .funct3(RD_instr[14:12]),
                                  .funct7(RD_instr[31:25]),
                                  .ALUControl(ALUControl));

register_file register_file(.A1(RD_instr[19:15]),
                            .A2(RD_instr[24:20]),
                            .RD1(RD1),
                            .RD2(RD2),
                            .A3(RD_instr[11:7]),
                            .WD3(Result),
                            .WE3(RegWrite),
                            .clk(clk));

mux1 mux_2x1(.A(RD2),
             .B(imm_ext),
             .S(ALUSrc),
             .Y(src_B));

mux2 mux_2x1(.A(ALUResult),
             .B(Read_data),
             .S(ResultSrc),
             .Y(Result));

sign_extend sign_extend(.in(RD_instr),
                        .imm_ext(imm_ext),
                        .imm_src(imm_src[0]));

data_memory data_memory(.A(ALUResult),
                        .RD(Read_data),
                        .WD(RD2),
                        .clk(clk),
                        .WE(MemWrite));

endmodule

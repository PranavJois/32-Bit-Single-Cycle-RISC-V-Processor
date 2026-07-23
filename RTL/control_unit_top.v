`include "alu_decoder.v"
`include "main_decoder.v"

module control_unit_top(Z,opcode,PCSrc,ResultSrc,MemWrite,ALUSrc,ImmSrc,RegWrite,funct3,funct7,ALUControl);

input [6:0]opcode,funct7;
input [2:0] funct3;
input Z;
output ResultSrc,MemWrite,ALUSrc,RegWrite,PCSrc;
output [1:0] ImmSrc;
output [2:0] ALUControl;

wire [1:0] ALUOp;
wire funct7_bit;
wire op5;

assign op5 = opcode[5];
assign funct7_bit = funct7[5];

main_decoder main_decoder(.Z(Z),
                          .opcode(opcode),
                          .ALUOp(ALUOp),
                          .PCSrc(PCSrc),
                          .ResultSrc(ResultSrc),
                          .MemWrite(MemWrite),
                          .ALUSrc(ALUSrc),
                          .ImmSrc(ImmSrc),
                          .RegWrite(RegWrite));

alu_decoder alu_decoder(.funct3(funct3),
                        .funct7(funct7_bit),
                        .op5(op5),
                        .ALUOp(ALUOp),
                        .ALUControl(ALUControl));

endmodule

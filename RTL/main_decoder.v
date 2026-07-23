module main_decoder(Z,opcode,ALUOp,PCSrc,ResultSrc,MemWrite,ALUSrc,ImmSrc,RegWrite);

input [6:0] opcode;
input Z;
output ResultSrc,MemWrite,ALUSrc,RegWrite,PCSrc;
output [1:0] ALUOp,ImmSrc;
wire Branch;

assign PCSrc = Branch & Z;

assign Branch = (opcode==7'b1100011) ? 1'b1 : 1'b0;
assign ResultSrc = (opcode==7'b0000011) ? 1'b1 : 1'b0;
assign MemWrite = (opcode==7'b0100011) ? 1'b1 : 1'b0;
assign ALUSrc = ((opcode==7'b0000011)||(opcode==7'b0100011)) ? 1'b1 : 1'b0;
assign RegWrite = ((opcode==7'b0000011)||(opcode==7'b0110011)) ? 1'b1 : 1'b0;
assign ImmSrc = ((opcode==7'b0000011)||(opcode==7'b0110011)) ? 2'b00 : (opcode==7'b0100011) ? 2'b01 : (opcode==7'b1100011) ? 2'b10 : 2'b00;
assign ALUOp = ((opcode==7'b0000011)||(opcode==7'b0100011)) ? 2'b00 : (opcode==7'b0110011) ? 2'b10 : (opcode==7'b1100011) ? 2'b01 : 2'b00;

endmodule

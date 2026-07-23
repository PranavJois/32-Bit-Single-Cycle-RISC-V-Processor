module sign_extend(in, imm_ext,imm_src);

input [31:0] in;
input imm_src;
output [31:0] imm_ext;

assign imm_ext = (imm_src) ? {{20{in[31]}},in[31:25],in[11:7]} : {{20{in[31]}},in[31:20]};

endmodule


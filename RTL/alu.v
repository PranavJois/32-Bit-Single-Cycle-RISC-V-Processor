module alu(A,B,ALUControl,Result, Z,N,V,C);

input [31:0] A,B;
input [2:0] ALUControl;
output reg [31:0] Result;

output Z,N,V,C;

wire [31:0] sum;
wire [31:0] zero_ext;
wire cout;
wire overflow;

assign {cout,sum} = (ALUControl[0]) ? A+((~B)+1) : A+B;
assign overflow = (~ALUControl[1]) &
                  (A[31]^sum[31]) &
                  (~(A[31]^B[31]^ALUControl[0]));

assign zero_ext = {31'b0, (sum[31]^overflow)};

assign V = overflow;
assign N = Result[31];
assign Z = ~|Result;
assign C = (cout & (~ALUControl[1]));

always@(*)
begin
    case(ALUControl)
        3'b000 : Result = sum;
        3'b001 : Result = sum;
        3'b010 : Result = A&B;
        3'b011 : Result = A|B;
        3'b101 : Result = zero_ext;
        default : Result = 32'd0;
    endcase
end
endmodule

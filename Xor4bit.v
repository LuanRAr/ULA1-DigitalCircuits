module Xor4bit(A, B, S);

input [3:0] A, B;
output [7:0] S;

xor xor0(S[0], A[0], B[0]);
xor xor1(S[1], A[1], B[1]);
xor xor2(S[2], A[2], B[2]);
xor xor3(S[3], A[3], B[3]);

and and4(S[4], 1'b0, 1'b0);
and and5(S[5], 1'b0, 1'b0);
and and6(S[6], 1'b0, 1'b0);
and and7(S[7], 1'b0, 1'b0);

endmodule
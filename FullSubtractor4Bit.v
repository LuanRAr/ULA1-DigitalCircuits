module FullSubtractor4Bit(A, B, Cin, Cout, S);

//inputs e outputs
input [3:0] A, B;    
input Cin;           
output [7:0] S;     
output Cout;        

// Fios internos para propagar os empréstimos entre os subtratores
wire c0, c1, c2, c3; 

// Subtrator de 1 bit para o bit menos significativo
FullSubtractor1Bit s0 (
	.A(A[0]),
	.B(B[0]),
	.Cin(Cin),
	.Cout(c0),   
	.S(S[0])      
);

// Subtrator de 1 bit para o bit 1
FullSubtractor1Bit s1 (
	.A(A[1]),
	.B(B[1]),
	.Cin(c0),
	.Cout(c1),
	.S(S[1])      // Resultado do bit 1
);

// Subtrator de 1 bit para o bit 2
FullSubtractor1Bit s2 (
	.A(A[2]),
	.B(B[2]),
	.Cin(c1),
	.Cout(c2),
	.S(S[2])      // Resultado do bit 2
);

// Subtrator de 1 bit para o bit mais significativo (bit 3)
FullSubtractor1Bit s3 (
	.A(A[3]),
	.B(B[3]),
	.Cin(c2),
	.Cout(Cout), 
	.S(S[3])   
);

// Como a saída foi declarada com 8 bits, os 4 bits mais altos são forçados a 0
and and4(S[4], 1'b0, 1'b0);
and and5(S[5], 1'b0, 1'b0);
and and6(S[6], 1'b0, 1'b0);
and and7(S[7], 1'b0, 1'b0);

endmodule

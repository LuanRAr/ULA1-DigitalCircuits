module FullAdder4Bit(A, B, Cin, Cout, S);
input [3:0] A, B; 
input Cin;       
output [7:0] S;   
output Cout;     

//Fios internos para transportar os carries entre os somadores
wire c0, c1, c2, c3; 

//Somador completo de 1 bit para o bit menos significativo
FullAdder1Bit a0 (
	.A(A[0]),
	.B(B[0]),
	.Cin(Cin),
	.Cout(c0),   // Carry gerado vai para o próximo estágio
	.S(S[0])     // Resultado da soma do bit 0
);

//Somador completo de 1 bit para o bit 1
FullAdder1Bit a1 (
	.A(A[1]),
	.B(B[1]),
	.Cin(c0),
	.Cout(c1),   // Carry gerado vai para o próximo estágio
	.S(S[1])     // Resultado da soma do bit 1
);

//Somador completo de 1 bit para o bit 2
FullAdder1Bit a2 (
	.A(A[2]),
	.B(B[2]),
	.Cin(c1),
	.Cout(c2),   // Carry gerado vai para o próximo estágio
	.S(S[2])     // Resultado da soma do bit 2
);

//Somador completo de 1 bit para o bit mais significativo (bit 3)
FullAdder1Bit a3 (
	.A(A[3]),
	.B(B[3]),
	.Cin(c2),
	.Cout(Cout), // Carry final de saída
	.S(S[3])     // Resultado da soma do bit 3
);

// Como a saída foi declarada com 8 bits, os 4 bits mais altos são forçados a 0
and and4(S[4], 1'b0, 1'b0);
and and5(S[5], 1'b0, 1'b0);
and and6(S[6], 1'b0, 1'b0);
and and7(S[7], 1'b0, 1'b0);

endmodule

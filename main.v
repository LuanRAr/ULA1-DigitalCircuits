module main(A, B, Cin, error, zero, S, Cout, Selector, seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g, unit_a, unit_b, unit_c, unit_d, unit_e, unit_f, unit_g, tens_a, tens_b, tens_c, tens_d, tens_e, tens_f, tens_g);

input [3:0] A, B;
input Cin;
input [2:0] Selector;
output Cout;

//display operações
output seg_a, seg_b, seg_c, seg_d, seg_e, seg_f, seg_g;

//display unidades
output unit_a, unit_b, unit_c, unit_d, unit_e, unit_f, unit_g;

//display dezenas
output tens_a, tens_b, tens_c, tens_d, tens_e, tens_f, tens_g;

output error, zero;
output [7:0] S; 
wire Ov;

wire [7:0]AdderOut, SubtractorOut, AndOut, OrOut, XorOut, MultiplierOut, DividerOut;


// Define a flag zero como 1 sempre que o resultado S for 0.
wire s_or_sum1, s_or_sum2, s_or_sum3, s_or_sum4, s_or_sum5, s_or_sum6, s_or_sum7;
or or1 (s_or_sum1, S[0], S[1]);
or or2 (s_or_sum2, s_or_sum1, S[2]);
or or3 (s_or_sum3, s_or_sum2, S[3]);
or or4 (s_or_sum4, s_or_sum3, S[4]);
or or5 (s_or_sum5, s_or_sum4, S[5]);
or or6 (s_or_sum6, s_or_sum5, S[6]);
or or7 (s_or_sum7, s_or_sum6, S[7]);
not not_zero (zero, s_or_sum7);

// FLAG DE ERRO E OVERFLOW
wire is_div_by_zero, is_b_zero, or_b_bits, is_division;
wire not_selector_1, not_selector_0;

// Lógica para detectar se B é zero
or or_b_is_zero (or_b_bits, B[0], B[1], B[2], B[3]);
not not_b_is_zero (is_b_zero, or_b_bits);

// Lógica para detectar se a operação é de divisão (Selector = 100)
not not_sel_1 (not_selector_1, Selector[1]);
not not_sel_0 (not_selector_0, Selector[0]);
and and_is_division (is_division, Selector[2], not_selector_1, not_selector_0);

// A divisão por zero ocorre se a operação for divisão E B for zero
and and_div_by_zero (is_div_by_zero, is_division, is_b_zero);

// A saída de erro será ativada por divisão por zero OU por overflow (Ov > 99)
or or_error(error, is_div_by_zero, Ov);

//Somador
FullAdder4Bit adder(
	.A(A),
	.B(B),
	.Cin(Cin),
	.Cout(AdderCout),
	.S(AdderOut)
);

//Subtrator
FullSubtractor4Bit subtractor(
	.A(A),
	.B(B),
	.Cin(Cin),
	.Cout(SubtractorCout),
	.S(SubtractorOut)
);

//Multiplicador
Multiplier multiplier4bit(
	.A(A),
	.B(B),
	.P(MultiplierOut)
);

//Divisor
Divider divider4bit(
	.A(A),
	.B(B),
	.Q(DividerOut)
);

//And
And4bit and4bit(
	.A(A),
	.B(B),
	.S(AndOut)
);

//Or
Or4bit or4bit(
	.A(A),
	.B(B),
	.S(OrOut)
);

//Xor
Xor4bit xor4bit(
	.A(A),
	.B(B),
	.S(XorOut)
);

//Muxes 0 ao 7
mux8to1 mux0(
	.NotUse(8'b00000000),     //000	
	.Add(AdderOut[0]),        //001
	.Sub(SubtractorOut[0]),   //010
	.Mul(MultiplierOut[0]),   //011
	.Div(DividerOut[0]),      //100
	.And(AndOut[0]),          //101
	.Or(OrOut[0]),            //110
	.Xor(XorOut[0]),          //111	
	.Selector(Selector),
	.Y(S[0])
);

mux8to1 mux1(
	.NotUse(8'b00000000),     //000	
	.Add(AdderOut[1]),        //001
	.Sub(SubtractorOut[1]),   //010
	.Mul(MultiplierOut[1]),   //011
	.Div(DividerOut[1]),      //100
	.And(AndOut[1]),          //101
	.Or(OrOut[1]),            //110
	.Xor(XorOut[1]),          //111	
	.Selector(Selector),
	.Y(S[1])
);

mux8to1 mux2(
	.NotUse(8'b00000000),  //000	
	.Add(AdderOut[2]),        //001
	.Sub(SubtractorOut[2]),   //010
	.Mul(MultiplierOut[2]),   //011
	.Div(DividerOut[2]),      //100
	.And(AndOut[2]),          //101
	.Or(OrOut[2]),            //110
	.Xor(XorOut[2]),          //111	
	.Selector(Selector),
	.Y(S[2])
);

mux8to1 mux3(
	.NotUse(8'b00000000),  //000	
	.Add(AdderOut[3]),        //001
	.Sub(SubtractorOut[3]),   //010
	.Mul(MultiplierOut[3]),   //011
	.Div(DividerOut[3]),      //100
	.And(AndOut[3]),          //101
	.Or(OrOut[3]),            //110
	.Xor(XorOut[3]),          //111	
	.Selector(Selector),
	.Y(S[3])
);

mux8to1 mux4(
	.NotUse(8'b00000000),  //000	
	.Add(AdderOut[4]),        //001
	.Sub(SubtractorOut[4]),   //010
	.Mul(MultiplierOut[4]),   //011
	.Div(DividerOut[4]),      //100
	.And(AndOut[4]),          //101
	.Or(OrOut[4]),            //110
	.Xor(XorOut[4]),          //111	
	.Selector(Selector),
	.Y(S[4])
);

mux8to1 mux5(
	.NotUse(8'b00000000),  //000	
	.Add(AdderOut[5]),        //001
	.Sub(SubtractorOut[5]),   //010
	.Mul(MultiplierOut[5]),   //011
	.Div(DividerOut[5]),      //100
	.And(AndOut[5]),          //101
	.Or(OrOut[5]),            //110
	.Xor(XorOut[5]),          //111	
	.Selector(Selector),
	.Y(S[5])
);

mux8to1 mux6(
	.NotUse(8'b00000000),  //000	
	.Add(AdderOut[6]),        //001
	.Sub(SubtractorOut[6]),   //010
	.Mul(MultiplierOut[6]),   //011
	.Div(DividerOut[6]),      //100
	.And(AndOut[6]),          //101
	.Or(OrOut[6]),            //110
	.Xor(XorOut[6]),          //111	
	.Selector(Selector),
	.Y(S[6])
);

mux8to1 mux7(
	.NotUse(8'b00000000),  //000	
	.Add(AdderOut[7]),        //001
	.Sub(SubtractorOut[7]),   //010
	.Mul(MultiplierOut[7]),   //011
	.Div(DividerOut[7]),      //100
	.And(AndOut[7]),          //101
	.Or(OrOut[7]),            //110
	.Xor(XorOut[7]),          //111	
	.Selector(Selector),
	.Y(S[7])
);

//Mux para escolher o COut
mux8to1 muxCout(
   .NotUse(1'b0),
	.Add(AdderCout), 
	.Sub(SubtractorCout), 
	.Mul(1'b0), 
	.Div(1'b0), 
	.And(1'b0), 
	.Or(1'b0), 
	.Xor(1'b0),     
	.Selector(Selector),
	.Y(Cout)
);

//Decoder e operações
DecoderOps decoderoperacoes(
	.A(Selector[0]), 
	.B(Selector[1]),
	.C(Selector[2]),
	.a(seg_a),
	.b(seg_b),
	.c(seg_c),
	.d(seg_d),
	.e(seg_e),
	.f(seg_f),
	.g(seg_g)
);

//Conversor bin to bcd
ResultConverter ResultToConverter(
	.b(S),
	.D3(D3),
	.D2(D2),
	.D1(D1),
	.D0(D0),
	.U3(U3),
	.U2(U2),
	.U1(U1),
	.U0(U0),
	.Ov(Ov)
);

//Decoder das unidades
DecoderResults decoderUnits(
	.A(U3),
	.B(U2),
	.C(U1),
	.D(U0),
	.a(unit_a),
	.b(unit_b),
	.c(unit_c),
	.d(unit_d),
	.e(unit_e),
	.f(unit_f),
	.g(unit_g)
);

//Decoder das dezenas
DecoderResults decoderTens(
	.A(D3),
	.B(D2),
	.C(D1),
	.D(D0),
	.a(tens_a),
	.b(tens_b),
	.c(tens_c),
	.d(tens_d),
	.e(tens_e),
	.f(tens_f),
	.g(tens_g)
);

endmodule
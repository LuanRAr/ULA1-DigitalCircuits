module DecoderOps(A, B, C, a, b, c, d, e, f, g);
input A, B, C;          
output a, b, c, d, e, f, g; 

//Fios para os sinais invertidos das entradas
wire not_A, not_B, not_C;

//Fios intermediários para combinações lógicas
wire s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13;

//Inversores das entradas
not nA(not_A, A);
not nB(not_B, B);
not nC(not_C, C);

//Lógica para gerar a saída a
and and1(s1, not_A, not_B, not_C);
and and2(s2, B, C);
or orA(a, s1, s2);

//Lógica para gerar a saída b
and (s3, not_A, not_C);
and (s4, B, not_C);
or orB(b, s3, s4);

//Lógica para gerar a saída c
and (s5, not_A, not_B, not_C);
and (s6, A, B, not_C);
or orC(c, s5, s6);

//Lógica para gerar a saída d
and (s7, A, B, C);
and (s8, not_A, not_B);
and (s9, not_B, not_C);
or orD(d, s7, s8, s9);

//Lógica para gerar a saída e
and andE(e, not_A, not_C);

//Lógica para gerar a saída f
and (s10, not_A, not_B, not_C);
and (s11, not_A, B, C);
or orF(f, s10, s11);

//Lógica para gerar a saída g
and (s12, not_B, not_C);
and (s13, A, not_B);
or orG(g, s12, s13);

endmodule

module FullAdder1Bit(A, B, Cin, Cout, S);
input A, B, Cin;  
output Cout, S;    

//Fios intermediários para operações lógicas
wire x1, a1, a2, a3; 

//Primeiro passo da soma
xor Xor1(x1, A, B);

//Gera a soma final (S)
xor Xor2(S, x1, Cin);

//Cálculo das condições que geram carry (Cout)
and And1(a1, A, Cin); 
and And2(a2, A, B); 
and And3(a3, B, Cin); 

//Combina as condições de carry para formar o Cout
or Or1(Cout, a1, a2, a3);

endmodule

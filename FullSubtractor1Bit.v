module FullSubtractor1Bit(A, B, Cin, Cout, S);
input A, B, Cin;    
output Cout, S;  

wire x1, a1, a2, a3; // Fios intermediários para cálculos lógicos
wire w_notA;         // Fio para armazenar o NOT de A

//Operação XOR para calcular A xor B
xor xor1 (x1, A, B);

//Operação XOR novamente para calcular o resultado final da subtração
xor xor2 (S, x1, Cin);

//Inverte A para usar na lógica de empréstimo
not notA (w_notA, A);

//Gera condições de empréstimo:
and and1 (a1, w_notA, B);    //Caso 1: A = 0, B = 1
and and2 (a2, w_notA, Cin);  //Caso 2: A = 0, Cin = 1
and and3 (a3, B, Cin);       //Caso 3: B = 1, Cin = 1

//Combina as condições para gerar o Cout (empréstimo de saída)
or or1 (Cout, a1, a2, a3);

endmodule

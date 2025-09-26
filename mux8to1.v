module mux8to1 (NotUse, Add, Sub, Mul, Div, And, Or, Xor, Selector, Y);

input NotUse, Add, Sub, Mul, Div, And, Or, Xor; 
input [2:0] Selector;                          
output Y;                                      

//Fios intermediários para o mux hierárquico
wire y1, y2, y3, y4; 

//Primeiros quatro mux2to1 para selecionar entre pares de entradas usando Selector[0]
mux2to1 mux1(
	.A(NotUse),
	.B(Add),
	.Selector(Selector[0]),
	.Y(y1)         
);

mux2to1 mux2(
	.A(Sub),
	.B(Mul),
	.Selector(Selector[0]),
	.Y(y2)        
);

mux2to1 mux3(
	.A(Div),
	.B(And),
	.Selector(Selector[0]),
	.Y(y3)          
);

mux2to1 mux4(
	.A(Or),
	.B(Xor),
	.Selector(Selector[0]),
	.Y(y4)          
);

//Mux4to1 para combinar as saídas intermediárias usando Selector[2:1]
mux4to1 mux5(
	.A(y1),
	.B(y2),
	.C(y3),
	.D(y4),
	.Selector(Selector[2:1]),
	.Y(Y)           
);

endmodule

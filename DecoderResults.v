module DecoderResults(A, B, C, D, a, b, c, d, e, f, g);
input A, B, C, D;
output a, b, c, d, e, f, g;

//wires negados
wire notA, notB, notC, notD;

not(notA, A);
not(notB, B);
not(notC, C);
not(notD, D);

//letra A
and (s1, B, notD);
and (s2, notA, notB, notC, D);
or (a, s1, s2);

//letra B
and (s3, B, notC, D);
and (s4, B, C, notD);
or (b, s3, s4);

//letra C
and (c, notB, C, notD);

//letra D
and (s5, notB, notC, D);
and (s6, B, notC, notD);
and (s7, B, C, D);
or (d, s5, s6, s7);

//letra E
and (s9, B, notC);
or (e, D, s9);

//letra F
and (s10, notA, notB, D);
and (s11, notB, C);
and (s12, C, D);
or (f, s10, s11, s12);

//letra g
and (s13, notA, notB, notC);
and (s14, B, C, D);

or (g, s13, s14);

endmodule
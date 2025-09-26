module Divider (A, B, Q, R);
    input [3:0] A, B;
    output [3:0] Q;
    output [3:0] R;


    // B estendido para 5 bits: b4 b3 b2 b1 b0 (b4 = 0)
    wire b4, b3, b2, b1, b0;
    buf (b4, 1'b0);
    buf (b3, B[3]);
    buf (b2, B[2]);
    buf (b1, B[1]);
    buf (b0, B[0]);

    // complemento de B (para subtração via A + ~B + 1)
    wire nb4, nb3, nb2, nb1, nb0;
    not (nb4, b4);
    not (nb3, b3);
    not (nb2, b2);
    not (nb1, b1);
    not (nb0, b0);

    // R0 = 0 (5 bits)
    wire r0_4, r0_3, r0_2, r0_1, r0_0;
    buf (r0_4, 1'b0);
    buf (r0_3, 1'b0);
    buf (r0_2, 1'b0);
    buf (r0_1, 1'b0);
    buf (r0_0, 1'b0);


    // ITERAÇÃO 1 (i = 3) :
    // r1_in = (r0 << 1) | A[3] -> r1in[4:0] = {r0_3, r0_2, r0_1, r0_0, A[3]}
    wire r1in4, r1in3, r1in2, r1in1, r1in0;
    buf (r1in4, r0_3);
    buf (r1in3, r0_2);
    buf (r1in2, r0_1);
    buf (r1in1, r0_0);
    buf (r1in0, A[3]);


    // bit0
    wire x10, t1_0, c1_0, g1_00, g1_01;
    xor (x10, r1in0, nb0);
    xor (t1_0, x10, 1'b1); //+1 (cin = 1)
    and (g1_00, r1in0, nb0);
    and (g1_01, x10, 1'b1);
    or (c1_0, g1_00, g1_01);

    // bit1
    wire x11, t1_1, c1_1, g1_10, g1_11;
    xor (x11, r1in1, nb1);
    xor (t1_1, x11, c1_0);
    and (g1_10, r1in1, nb1);
    and (g1_11, x11, c1_0);
    or (c1_1, g1_10, g1_11);

    // bit2
    wire x12, t1_2, c1_2, g1_20, g1_21;
    xor (x12, r1in2, nb2);
    xor (t1_2, x12, c1_1);
    and (g1_20, r1in2, nb2);
    and (g1_21, x12, c1_1);
    or (c1_2, g1_20, g1_21);

    // bit3
    wire x13, t1_3, c1_3, g1_30, g1_31;
    xor (x13, r1in3, nb3);
    xor (t1_3, x13, c1_2);
    and (g1_30, r1in3, nb3);
    and (g1_31, x13, c1_2);
    or (c1_3, g1_30, g1_31);

    // bit4 (MSB)
    wire x14, t1_4, c1_4, g1_40, g1_41;
    xor (x14, r1in4, nb4);
    xor (t1_4, x14, c1_3);
    and (g1_40, r1in4, nb4);
    and (g1_41, x14, c1_3);
    or (c1_4, g1_40, g1_41);

    // sinal de trial1 (MSB)
    wire trial1_neg, ntrial1;
    buf (trial1_neg, t1_4);
    not (ntrial1, trial1_neg); // 1 se trial >= 0

    // r1 = (trial1 >= 0) ? trial1 : r1_in
    wire r1_4, r1_3, r1_2, r1_1, r1_0;
    // bit0
    wire sel1a0, sel1b0;
    and (sel1a0, t1_0, ntrial1); 
    and (sel1b0, r1in0, trial1_neg);
    or (r1_0, sel1a0, sel1b0);

    // bit1
    wire sel1a1, sel1b1;
    and (sel1a1, t1_1, ntrial1);
    and (sel1b1, r1in1, trial1_neg);
    or (r1_1, sel1a1, sel1b1);

    // bit2
    wire sel1a2, sel1b2;
    and (sel1a2, t1_2, ntrial1);
    and (sel1b2, r1in2, trial1_neg);
    or (r1_2, sel1a2, sel1b2);

    // bit3
    wire sel1a3, sel1b3;
    and (sel1a3, t1_3, ntrial1);
    and (sel1b3, r1in3, trial1_neg);
    or (r1_3, sel1a3, sel1b3);

    // bit4
    wire sel1a4, sel1b4;
    and (sel1a4, t1_4, ntrial1);
    and (sel1b4, r1in4, trial1_neg);
    or (r1_4, sel1a4, sel1b4);

    buf (Q[3], ntrial1);

    // ITERAÇÃO 2 (i = 2)
    // r2_in = (r1 << 1) | A[2] -> {r1_3, r1_2, r1_1, r1_0, A[2]}
    wire r2in4, r2in3, r2in2, r2in1, r2in0;
    buf (r2in4, r1_3);
    buf (r2in3, r1_2);
    buf (r2in2, r1_1);
    buf (r2in1, r1_0);
    buf (r2in0, A[2]);

    // bit0
    wire x20, t2_0, c2_0, g2_00, g2_01;
    xor (x20, r2in0, nb0);
    xor (t2_0, x20, 1'b1);
    and (g2_00, r2in0, nb0);
    and (g2_01, x20, 1'b1);
    or (c2_0, g2_00, g2_01);

    // bit1
    wire x21, t2_1, c2_1, g2_10, g2_11;
    xor (x21, r2in1, nb1);
    xor (t2_1, x21, c2_0);
    and (g2_10, r2in1, nb1);
    and (g2_11, x21, c2_0);
    or (c2_1, g2_10, g2_11);

    // bit2
    wire x22, t2_2, c2_2, g2_20, g2_21;
    xor (x22, r2in2, nb2);
    xor (t2_2, x22, c2_1);
    and (g2_20, r2in2, nb2);
    and (g2_21, x22, c2_1);
    or (c2_2, g2_20, g2_21);

    // bit3
    wire x23, t2_3, c2_3, g2_30, g2_31;
    xor (x23, r2in3, nb3);
    xor (t2_3, x23, c2_2);
    and (g2_30, r2in3, nb3);
    and (g2_31, x23, c2_2);
    or (c2_3, g2_30, g2_31);

    // bit4
    wire x24, t2_4, c2_4, g2_40, g2_41;
    xor (x24, r2in4, nb4);
    xor (t2_4, x24, c2_3);
    and (g2_40, r2in4, nb4);
    and (g2_41, x24, c2_3);
    or (c2_4, g2_40, g2_41);

    // sinal e mux para r2
    wire trial2_neg, ntrial2;
    buf (trial2_neg, t2_4);
    not (ntrial2, trial2_neg);

    wire r2_4, r2_3, r2_2, r2_1, r2_0;
    and (sel2a0, t2_0, ntrial2); and (sel2b0, r2in0, trial2_neg); or (r2_0, sel2a0, sel2b0);
    and (sel2a1, t2_1, ntrial2); and (sel2b1, r2in1, trial2_neg); or (r2_1, sel2a1, sel2b1);
    and (sel2a2, t2_2, ntrial2); and (sel2b2, r2in2, trial2_neg); or (r2_2, sel2a2, sel2b2);
    and (sel2a3, t2_3, ntrial2); and (sel2b3, r2in3, trial2_neg); or (r2_3, sel2a3, sel2b3);
    and (sel2a4, t2_4, ntrial2); and (sel2b4, r2in4, trial2_neg); or (r2_4, sel2a4, sel2b4);

    buf (Q[2], ntrial2);

    // ITERAÇÃO 3 (i = 1)
    // r3_in = {r2_3, r2_2, r2_1, r2_0, A[1]}
    wire r3in4, r3in3, r3in2, r3in1, r3in0;
    buf (r3in4, r2_3);
    buf (r3in3, r2_2);
    buf (r3in2, r2_1);
    buf (r3in1, r2_0);
    buf (r3in0, A[1]);

    // bit0
    wire x30, t3_0, c3_0, g3_00, g3_01;
    xor (x30, r3in0, nb0);
    xor (t3_0, x30, 1'b1);
    and (g3_00, r3in0, nb0);
    and (g3_01, x30, 1'b1);
    or (c3_0, g3_00, g3_01);

    // bit1
    wire x31, t3_1, c3_1, g3_10, g3_11;
    xor (x31, r3in1, nb1);
    xor (t3_1, x31, c3_0);
    and (g3_10, r3in1, nb1);
    and (g3_11, x31, c3_0);
    or (c3_1, g3_10, g3_11);

    // bit2
    wire x32, t3_2, c3_2, g3_20, g3_21;
    xor (x32, r3in2, nb2);
    xor (t3_2, x32, c3_1);
    and (g3_20, r3in2, nb2);
    and (g3_21, x32, c3_1);
    or (c3_2, g3_20, g3_21);

    // bit3
    wire x33, t3_3, c3_3, g3_30, g3_31;
    xor (x33, r3in3, nb3);
    xor (t3_3, x33, c3_2);
    and (g3_30, r3in3, nb3);
    and (g3_31, x33, c3_2);
    or (c3_3, g3_30, g3_31);

    // bit4
    wire x34, t3_4, c3_4, g3_40, g3_41;
    xor (x34, r3in4, nb4);
    xor (t3_4, x34, c3_3);
    and (g3_40, r3in4, nb4);
    and (g3_41, x34, c3_3);
    or (c3_4, g3_40, g3_41);

    // sinal e mux para r3
    wire trial3_neg, ntrial3;
    buf (trial3_neg, t3_4);
    not (ntrial3, trial3_neg);

    wire r3_4, r3_3, r3_2, r3_1, r3_0;
    and (sel3a0, t3_0, ntrial3); and (sel3b0, r3in0, trial3_neg); or (r3_0, sel3a0, sel3b0);
    and (sel3a1, t3_1, ntrial3); and (sel3b1, r3in1, trial3_neg); or (r3_1, sel3a1, sel3b1);
    and (sel3a2, t3_2, ntrial3); and (sel3b2, r3in2, trial3_neg); or (r3_2, sel3a2, sel3b2);
    and (sel3a3, t3_3, ntrial3); and (sel3b3, r3in3, trial3_neg); or (r3_3, sel3a3, sel3b3);
    and (sel3a4, t3_4, ntrial3); and (sel3b4, r3in4, trial3_neg); or (r3_4, sel3a4, sel3b4);

    buf (Q[1], ntrial3);

    // ITERAÇÃO 4 (i = 0)
    // r4_in = {r3_3, r3_2, r3_1, r3_0, A[0]}
    wire r4in4, r4in3, r4in2, r4in1, r4in0;
    buf (r4in4, r3_3);
    buf (r4in3, r3_2);
    buf (r4in2, r3_1);
    buf (r4in1, r3_0);
    buf (r4in0, A[0]);

    // bit0
    wire x40, t4_0, c4_0, g4_00, g4_01;
    xor (x40, r4in0, nb0);
    xor (t4_0, x40, 1'b1);
    and (g4_00, r4in0, nb0);
    and (g4_01, x40, 1'b1);
    or (c4_0, g4_00, g4_01);

    // bit1
    wire x41, t4_1, c4_1, g4_10, g4_11;
    xor (x41, r4in1, nb1);
    xor (t4_1, x41, c4_0);
    and (g4_10, r4in1, nb1);
    and (g4_11, x41, c4_0);
    or (c4_1, g4_10, g4_11);

    // bit2
    wire x42, t4_2, c4_2, g4_20, g4_21;
    xor (x42, r4in2, nb2);
    xor (t4_2, x42, c4_1);
    and (g4_20, r4in2, nb2);
    and (g4_21, x42, c4_1);
    or (c4_2, g4_20, g4_21);

    // bit3
    wire x43, t4_3, c4_3, g4_30, g4_31;
    xor (x43, r4in3, nb3);
    xor (t4_3, x43, c4_2);
    and (g4_30, r4in3, nb3);
    and (g4_31, x43, c4_2);
    or (c4_3, g4_30, g4_31);

    // bit4
    wire x44, t4_4, c4_4, g4_40, g4_41;
    xor (x44, r4in4, nb4);
    xor (t4_4, x44, c4_3);
    and (g4_40, r4in4, nb4);
    and (g4_41, x44, c4_3);
    or (c4_4, g4_40, g4_41);

    // sinal e mux para r4
    wire trial4_neg, ntrial4;
    buf (trial4_neg, t4_4);
    not (ntrial4, trial4_neg);

    wire r4_4, r4_3, r4_2, r4_1, r4_0;
    and (sel4a0, t4_0, ntrial4); and (sel4b0, r4in0, trial4_neg); or (r4_0, sel4a0, sel4b0);
    and (sel4a1, t4_1, ntrial4); and (sel4b1, r4in1, trial4_neg); or (r4_1, sel4a1, sel4b1);
    and (sel4a2, t4_2, ntrial4); and (sel4b2, r4in2, trial4_neg); or (r4_2, sel4a2, sel4b2);
    and (sel4a3, t4_3, ntrial4); and (sel4b3, r4in3, trial4_neg); or (r4_3, sel4a3, sel4b3);
    and (sel4a4, t4_4, ntrial4); and (sel4b4, r4in4, trial4_neg); or (r4_4, sel4a4, sel4b4);

    // q[0] = 1 se trial4 >= 0
    buf (Q[0], ntrial4);

    // ------------------------
    // Saída do resto: os 4 bits menores de r4 (r4_3..r4_0)
    buf (R[0], r4_0);
    buf (R[1], r4_1);
    buf (R[2], r4_2);
    buf (R[3], r4_3);

endmodule
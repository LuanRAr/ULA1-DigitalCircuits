module ResultConverter (D3, D2, D1, D0, U3, U2, U1, U0, Ov, b);
    // Inputs
    input [7:0] b;

    // Outputs
    output D3, D2, D1, D0, U3, U2, U1, U0, Ov;

    // Wires internos para entradas invertidas
    wire nb0, nb1, nb2, nb3, nb4, nb5, nb6, nb7;

    // Wires para termos de produto
    wire d3_t1, d3_t2;
    wire d2_t1, d2_t2, d2_t3;
    wire d1_t1, d1_t2, d1_t3, d1_t4, d1_t5, d1_t6;
    wire d0_t1, d0_t2, d0_t3, d0_t4, d0_t5, d0_t6, d0_t7, d0_t8, d0_t9, d0_t10, d0_t11, d0_t12;
    wire u3_t1, u3_t2, u3_t3, u3_t4, u3_t5;
    wire u2_t1, u2_t2, u2_t3, u2_t4, u2_t5, u2_t6, u2_t7, u2_t8, u2_t9, u2_t10, u2_t11, u2_t12, u2_t13, u2_t14, u2_t15, u2_t16, u2_t17, u2_t18, u2_t19, u2_t20;
    wire u1_t1, u1_t2, u1_t3, u1_t4, u1_t5, u1_t6, u1_t7, u1_t8, u1_t9, u1_t10, u1_t11, u1_t12, u1_t13;
    wire u0_t1, u0_t2, u0_t3;

    //Inversões
    not inv_b0 (nb0, b[0]);
    not inv_b1 (nb1, b[1]);
    not inv_b2 (nb2, b[2]);
    not inv_b3 (nb3, b[3]);
    not inv_b4 (nb4, b[4]);
    not inv_b5 (nb5, b[5]);
    not inv_b6 (nb6, b[6]);
    not inv_b7 (nb7, b[7]);


    // D3
    and and_d3_t1 (d3_t1, nb7, b[6], nb5, b[4]);
    and and_d3_t2 (d3_t2, nb7, b[6], b[5], nb4, nb3, nb2);
    or  or_d3 (D3, d3_t1, d3_t2);

    // D2
    and and_d2_t1 (d2_t1, nb7, nb6, b[5], b[3]);
    and and_d2_t2 (d2_t2, nb7, nb6, b[5], b[4]);
    and and_d2_t3 (d2_t3, nb7, b[6], nb5, nb4);
    or  or_d2 (D2, d2_t1, d2_t2, d2_t3);

    // D1
    and and_d1_t1 (d1_t1, nb7, nb6, nb5, b[4], b[2], b[0]);
    and and_d1_t2 (d1_t2, nb7, nb6, nb5, b[4], b[2], b[1]);
    and and_d1_t3 (d1_t3, nb7, nb6, nb5, b[4], b[3]);
    and and_d1_t4 (d1_t4, nb7, nb6, b[5], nb4, nb3);
    and and_d1_t5 (d1_t5, nb7, nb6, b[4], b[3], b[2]);
    and and_d1_t6 (d1_t6, nb7, b[6], nb5, nb4);
    or  or_d1 (D1, d1_t1, d1_t2, d1_t3, d1_t4, d1_t5, d1_t6);

    // D0
    and and_d0_t1 (d0_t1, nb7, nb5, nb4, b[3], b[1]);
    and and_d0_t2 (d0_t2, nb7, nb5, nb4, b[3], b[2]);
    and and_d0_t3 (d0_t3, nb7, nb6, nb5, b[4], nb3, nb2);
    and and_d0_t4 (d0_t4, nb7, nb5, b[3], b[2], b[1]);
    and and_d0_t5 (d0_t5, nb7, nb6, b[5], nb3, b[2]);
    and and_d0_t6 (d0_t6, nb7, nb6, b[5], b[4], b[3], nb2);
    and and_d0_t7 (d0_t7, nb7, b[6], nb5, nb4, b[2], b[1]);
    and and_d0_t8 (d0_t8, nb7, b[6], nb5, nb4, b[3]);
    and and_d0_t9 (d0_t9, nb7, b[6], nb5, b[3], b[1]);
    and and_d0_t10(d0_t10, nb7, b[6], nb5, b[3], b[2]);
    and and_d0_t11(d0_t11, nb7, b[5], nb4, nb3, nb2);
    and and_d0_t12(d0_t12, nb7, nb6, b[4], nb3, nb2, b[1]);
    or  or_d0 (D0, d0_t1, d0_t2, d0_t3, d0_t4, d0_t5, d0_t6, d0_t7, d0_t8, d0_t9, d0_t10, d0_t11, d0_t12);

    // U3
    and and_u3_t1 (u3_t1, nb7, nb6, b[5]);
    and and_u3_t2 (u3_t2, nb7, b[6], nb5);
    and and_u3_t3 (u3_t3, nb7, nb6, b[4], b[3], nb2, nb1);
    and and_u3_t4 (u3_t4, nb7, nb6, b[4], b[3], nb2, b[1]);
    and and_u3_t5 (u3_t5, nb7, b[6], b[4], b[3], b[2]);
    and and_u3_t6 (u3_t6, nb7, b[5], nb4, nb3, nb2);
    or  or_u3 (U3, u3_t1, u3_t2, u3_t3, u3_t4, u3_t5, u3_t6);

    // U2
    and and_u2_t1 (u2_t1, nb7, nb6, nb5, nb4, nb3, b[2], nb1, nb0);
    and and_u2_t2 (u2_t2, nb7, nb6, nb5, nb4, nb3, b[2], b[1], b[0]);
    and and_u2_t3 (u2_t3, nb7, nb6, nb5, nb4, b[3], b[2], b[1], nb0);
    and and_u2_t4 (u2_t4, nb7, nb6, nb5, b[4], nb3, nb2, nb1, b[0]);
    and and_u2_t5 (u2_t5, nb7, nb6, nb5, b[4], b[3], nb2, nb1, nb0);
    and and_u2_t6 (u2_t6, nb7, nb6, nb5, b[4], b[3], nb2, b[1], b[0]);
    and and_u2_t7 (u2_t7, nb7, nb6, b[5], nb4, nb3, nb2, b[1], nb0);
    and and_u2_t8 (u2_t8, nb7, nb6, b[5], nb4, nb3, b[2], nb1, b[0]);
    and and_u2_t9 (u2_t9, nb7, nb6, b[5], nb4, b[3], nb2, nb1, nb0);
    and and_u2_t10(u2_t10, nb7, nb6, b[5], nb4, b[3], b[2], b[1], b[0]);
    and and_u2_t11(u2_t11, nb7, nb6, b[5], b[4], nb3, b[2], b[1], nb0);
    and and_u2_t12(u2_t12, nb7, nb6, b[5], b[4], b[3], nb2, nb1, b[0]);
    and and_u2_t13(u2_t13, nb7, b[6], b[5], nb4, nb3, nb2, nb1, nb0);
    and and_u2_t14(u2_t14, nb7, b[6], b[5], nb4, nb3, nb2, b[1], b[0]);
    and and_u2_t15(u2_t15, nb7, b[6], b[5], nb4, b[3], nb2, b[1], nb0);
    and and_u2_t16(u2_t16, nb7, b[6], b[5], nb4, b[3], b[2], nb1, b[0]);
    and and_u2_t17(u2_t17, nb7, b[6], nb5, b[4], nb3, b[2], nb1, nb0);
    and and_u2_t18(u2_t18, nb7, b[6], nb5, b[4], nb3, b[2], b[1], b[0]);
    and and_u2_t19(u2_t19, nb7, b[6], nb5, b[4], b[3], b[2], b[1], nb0);
    and and_u2_t20(u2_t20, nb7, b[6], b[5], nb4, nb3, nb2, nb1, b[0]);
    or  or_u2 (U2, u2_t1, u2_t2, u2_t3, u2_t4, u2_t5, u2_t6, u2_t7, u2_t8, u2_t9, u2_t10, u2_t11, u2_t12, u2_t13, u2_t14, u2_t15, u2_t16, u2_t17, u2_t18, u2_t19, u2_t20);

    // U1
    and and_u1_t1 (u1_t1, nb7, nb5, nb4, b[3], b[2], nb1);
    and and_u1_t2 (u1_t2, nb7, nb6, nb5, b[4], nb3, nb2, nb1);
    and and_u1_t3 (u1_t3, nb7, nb6, nb5, b[4], b[3], nb2, b[1]);
    and and_u1_t4 (u1_t4, nb7, nb6, b[5], nb4, b[3], b[1]);
    and and_u1_t5 (u1_t5, nb7, nb6, b[5], nb3, b[2], nb1);
    and and_u1_t6 (u1_t6, nb7, nb6, b[5], b[4], b[3], nb2, nb1);
    and and_u1_t7 (u1_t7, nb7, nb6, b[5], b[3], b[2], b[1]);
    and and_u1_t8 (u1_t8, nb7, b[6], nb5, nb4, b[3], nb1);
    and and_u1_t9 (u1_t9, nb7, b[6], nb5, b[3], b[2], nb1);
    and and_u1_t10(u1_t10, nb7, b[5], nb4, nb3, nb2, nb1);
    and and_u1_t11(u1_t11, nb7, nb6, nb5, nb4, nb3, b[1]);
    and and_u1_t12(u1_t12, nb7, b[5], b[4], nb3, b[2], b[1]);
    and and_u1_t13(u1_t13, nb7, b[6], nb5, nb3, nb2, b[1]);
    or  or_u1 (U1, u1_t1, u1_t2, u1_t3, u1_t4, u1_t5, u1_t6, u1_t7, u1_t8, u1_t9, u1_t10, u1_t11, u1_t12, u1_t13);

    // U0
    and and_u0_t1 (u0_t1, nb7, nb6, b[0]);
    and and_u0_t2 (u0_t2, nb7, nb5, b[0]);
    and and_u0_t3 (u0_t3, nb7, nb4, nb3, nb2, b[0]);
    or  or_u0 (U0, u0_t1, u0_t2, u0_t3);

    // Ov
    and and_ov (Ov, nb7, b[6], b[5], nb4, nb3, b[2], nb1, nb0);

endmodule
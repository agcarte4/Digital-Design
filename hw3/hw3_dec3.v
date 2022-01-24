//      module: hw3_dec3
//
//      desc:  Logic that subtracts 3 from a 5 bit input

module hw3_dec3 (
    input [4:0] A,
    output [4:0] F
);

    wire A3n, A2n, A1n, A0n;

    wire w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12;

    //Inverters
    not U1A ( A0n, A[0] );
    not U1B ( A1n, A[1] );
    not U1C ( A2n, A[2] );
    not U1D ( A3n, A[3] );

    //Code describing F4 output
    and U2A ( w0, A[0], A[1] );
    or U5A ( w1, w0, A[2], A[3] );
    and U2B ( F[4], w1, A[4] );

    //Code describing F3 output
    or U3A ( w2, w0, A[2] );
    and U2C ( w6, w2, A[3] );
    and U2D ( w3, A2n, A0n );
    and U2E ( w4, A2n, A1n );
    or U3B ( w5, w3, w4 );
    and U2F ( w7, w5, A3n );
    or U3C ( F[3], w6, w7 );

    //Code describing F2 output
    or U3D ( w8, A0n, A1n );
    and U2G ( w9, A2n, w8 );
    and U4A ( w10, A[2], A[1], A[0] );
    or U3E ( F[2], w9, w10 );

    //Code describing F1 output
    and U2H ( w11, A1n, A[0] );
    and U2I ( w12, A[1], A0n );
    or U3F ( F[1], w11, w12 );

    //Code describing F0 output
    assign F[0] = A0n;

endmodule


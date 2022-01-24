module sipo(
    input rst, clk,
    input in,
    output [15:0] bcd_A,
    output [15:0] bcd_B,
    output ctrl
);
    wire [3:0] Adigit [3:0];
    wire [3:0] Bdigit [3:0];
    wire w0;

    dff U0 (rst, clk, in, w0);
    sipo_str B3 (rst, clk, w0, Bdigit[3]);
    sipo_str B2 (rst, clk, Bdigit[3][0], Bdigit[2]);
    sipo_str B1 (rst, clk, Bdigit[2][0], Bdigit[1]);
    sipo_str B0 (rst, clk, Bdigit[1][0], Bdigit[0]);
    sipo_str A3 (rst, clk, Bdigit[0][0], Adigit[3]);
    sipo_str A2 (rst, clk, Adigit[3][0], Adigit[2]);
    sipo_str A1 (rst, clk, Adigit[2][0], Adigit[1]);
    sipo_str A0 (rst, clk, Adigit[1][0], Adigit[0]);

    assign ctrl = w0;
    assign bcd_A[3:0] = Adigit[0];
    assign bcd_A[7:4] = Adigit[1];
    assign bcd_A[11:8] = Adigit[2];
    assign bcd_A[15:12] = Adigit[3];
    assign bcd_B[3:0] = Bdigit[0];
    assign bcd_B[7:4] = Bdigit[1];
    assign bcd_B[11:8] = Bdigit[2];
    assign bcd_B[15:12] = Bdigit[3];

endmodule

module sipo_str (
  input rst, clk,
  input in,
  output [3:0] f
);

  dff msb ( rst, clk, in, f[3] );
  dff u2  ( rst, clk, f[3], f[2] );
  dff u1  ( rst, clk, f[2], f[1] );
  dff lsb ( rst, clk, f[1], f[0] );

endmodule

module dff (
  input rst, clk,
  input d,
  output reg q
);

  always @( posedge clk )
    if( rst )
      q <= 0;
    else
      q <= d;

endmodule

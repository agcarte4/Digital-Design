module serial_bcd_alu(
    input rst, clk,
    input en, in,
    output result
);

  wire [15:0] bcd_A;
  wire [15:0] bcd_B;
  wire [19:0] sum;
  wire [19:0] sum0;
  wire ctrl;
  wire load;
  wire sipo_ld;
  wire piso_ld;
  wire not_en;

  dff U4 (rst, clk, en, load);

  assign sipo_ld = en ? clk : 0;

  not U5 (not_en, en);
  and U6 (piso_ld, not_en, load);
  assign sum = piso_ld ? sum0 : 0;

  sipo U0 (rst, sipo_ld, in, bcd_A, bcd_B, ctrl);
  hw6_alu U1 (sum0, ctrl, bcd_A, bcd_B);
  piso U3 (rst, clk, sum, result);

endmodule

//FULL SIPO MODULE
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

module piso (
  input rst, clk,
  input [19:0] in, 
  output f
);

  wire [18:0] d;
  wire [18:0] q;

  dff msb ( rst, clk, in[19], q[18] );

  or U18 ( d[18], q[18], in[18] ); 
  dff bit18 ( rst, clk, d[18], q[17] );

  or U17 ( d[17], q[17], in[17] );
  dff bit17 ( rst, clk, d[17], q[16] );

  or U16 ( d[16], q[16], in[16] );
  dff bit16 ( rst, clk, d[16], q[15] );

  or U15 ( d[15], q[15], in[15] );
  dff bit15 ( rst, clk, d[15], q[14] );

  or U14 ( d[14], q[14], in[14] );
  dff bit14 ( rst, clk, d[14], q[13] );
  
  or U13 ( d[13], q[13], in[13] );
  dff bit13 ( rst, clk, d[13], q[12] );

  or U12 ( d[12], q[12], in[12] );
  dff bit12 ( rst, clk, d[12], q[11] );

  or U11 ( d[11], q[11], in[11] );
  dff bit11 ( rst, clk, d[11], q[10] );

  or U10 ( d[10], q[10], in[10] );
  dff bit10 ( rst, clk, d[10], q[9] );

  or U9 ( d[9], q[9], in[9] );
  dff bit9 ( rst, clk, d[9], q[8] );

  or U8 ( d[8], q[8], in[8] );
  dff bit8 ( rst, clk, d[8], q[7] );

  or U7 ( d[7], q[7], in[7] );
  dff bit7 ( rst, clk, d[7], q[6] );

  or U6 ( d[6], q[6], in[6] );
  dff bit6 ( rst, clk, d[6], q[5] );

  or U5 ( d[5], q[5], in[5] );
  dff bit5 ( rst, clk, d[5], q[4] );

  or U4 ( d[4], q[4], in[4] );
  dff bit4 ( rst, clk, d[4], q[4] );

  or U3 ( d[3], q[3], in[3] );
  dff bit3 ( rst, clk, d[3], q[2] );

  or U2 ( d[2], q[2], in[2]);
  dff bit2 ( rst, clk, d[2], q[1] );

  or U1 ( d[1], q[1], in[1] );
  dff bit1 ( rst, clk, d[1], q[0] );

  or U0 ( d[0], q[0], in[0]);
  dff lsb ( rst, clk, d[0], f );

endmodule


// BCD ALU module
module hw6_alu (
    output [19:0] result,
    input ctrl,
    input [15:0] bcd_A,
    input [15:0] bcd_B
  );

  wire [16:0] r1;
  wire [16:0] r2;
  wire [16:0] r2_0;
  wire [3:0] Bdigit [3:0];
  wire [3:0] Bnines [3:0];
  wire [15:0] bcd_B_nines;

  assign Bdigit[0] = bcd_B[ 3: 0];
  assign Bdigit[1] = bcd_B[ 7: 4];
  assign Bdigit[2] = bcd_B[11: 8];
  assign Bdigit[3] = bcd_B[15:12];

  nines_comp U0 (Bdigit[0], Bnines[0]);
  nines_comp U1 (Bdigit[1], Bnines[1]);
  nines_comp U2 (Bdigit[2], Bnines[2]);
  nines_comp U3 (Bdigit[3], Bnines[3]);
  
  assign bcd_B_nines[3:0] = Bnines[0];
  assign bcd_B_nines[7:4] = Bnines[1];
  assign bcd_B_nines[11:8] = Bnines[2];
  assign bcd_B_nines[15:12] = Bnines[3];

  assign result[17] = 0;
  assign result[18] = 0;
  assign result[19] = 0;

  hw4_q2b U4 (ctrl, bcd_A, bcd_B, r1);
  hw4_q2b U5 (ctrl, bcd_A, bcd_B_nines, r2_0);
 
  assign r2[16] = 0;                    ///wasn't sure how to change the 1 at r2[16]
  assign r2[15:0] = r2_0;

  assign result[16:0] = ctrl ? r2 : r1;  

endmodule

//NINES COMPLEMENT
module nines_comp(
    input [3:0] in, 
    output [3:0] out
);
    wire [3:0] carry;
    wire not_in3;
    wire not_in2;
    wire not_in1;

    not U0 (out[0], in[0]);
    not U1 (not_in1, in[1]);
    not U2 (not_in2, in[2]);
    not U3 (not_in3, in[3]);
    and U4 (out[3], not_in3, not_in2, not_in1);
    xor U5 (out[2], in[2], in[1]);
    assign out[1] = in[1];

endmodule

//BCD ADDER
module hw4_q2b (
  input C,
  input [15:0] A, B,
  output [16:0] S
);

  wire [3:0] Adigit [3:0];
  wire [3:0] Bdigit [3:0];
  wire [3:0] Sdigit [3:0];
  wire Smsb;
  wire [3:0] carry;

  assign Adigit[0] = A[ 3: 0];
  assign Adigit[1] = A[ 7: 4];
  assign Adigit[2] = A[11: 8];
  assign Adigit[3] = A[15:12];

  assign Bdigit[0] = B[ 3: 0];
  assign Bdigit[1] = B[ 7: 4];
  assign Bdigit[2] = B[11: 8];
  assign Bdigit[3] = B[15:12];

  assign S[ 3: 0] = Sdigit[0];
  assign S[ 7: 4] = Sdigit[1];
  assign S[11: 8] = Sdigit[2];
  assign S[15:12] = Sdigit[3];

  assign S[16] = Smsb;

  BCD_Add U0 ( C, Adigit[0], Bdigit[0], Sdigit[0], carry[0] );
  BCD_Add U1 ( carry[0], Adigit[1], Bdigit[1], Sdigit[1], carry[1] );
  BCD_Add U2 ( carry[1], Adigit[2], Bdigit[2], Sdigit[2], carry[2] );
  BCD_Add U3 ( carry[2], Adigit[3], Bdigit[3], Sdigit[3], Smsb );

endmodule

//COMBINES OUTPUTS TO RESULT
module BCD_Add (
  input C,
  input [3:0] A, B,
  output reg [3:0] Sum,
  output reg carry
);

  wire [4:0] i_sum;

  assign i_sum = A + B + C;

  always @( A, B, C ) begin
    if( i_sum > 9 ) begin
      carry = 1'b1;
      Sum = i_sum + 6;
    end
    else begin
      carry = 1'b0;
      Sum = i_sum;
    end
  end

endmodule
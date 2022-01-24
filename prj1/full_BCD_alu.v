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
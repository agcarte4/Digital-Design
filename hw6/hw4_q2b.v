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

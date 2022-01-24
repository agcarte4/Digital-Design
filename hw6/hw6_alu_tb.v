module hw6_alu_tb;

  reg [15:0] A, B;
  reg ctrl;
  wire [19:0] S;

  hw6_alu DUT ( .bcd_A(A), .bcd_B(B), .ctrl(ctrl), .result(S) );

  initial
  begin

    $monitor( $time, ": %1d%1d%1d%1d %s %1d%1d%1d%1d = %1d%1d%1d%1d%1d",
      A[15:12], A[11:8], A[7:4], A[3:0],
      ctrl ? "-" : "+",
      B[15:12], B[11:8], B[7:4], B[3:0],
      S[19:16], S[15:12], S[11:8], S[7:4], S[3:0]
    );

    // 2172 + 4678 = 6850
    ctrl = 0;
    A = 16'b0010_0001_0111_0010;
    B = 16'b0100_0110_0111_1000;

    #10
    // 4263 - 3147 = 1116
    ctrl = 1;
    A = 16'b0100_0010_0110_0011;
    B = 16'b0011_0001_0100_0111;

    #10 $stop;

  end

endmodule

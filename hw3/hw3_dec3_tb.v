module hw3_dec3_tb;

  reg  [4:0] A;
  wire [4:0] F;

  hw3_dec3 DUT ( .A(A), .F(F) );

  initial
    begin
      $monitor( $time, ": A = %5b (%2d), F = %5b (%2d)", A, A, F, F );

          A = 5'h00;
      #10 A = 5'h01;
      #10 A = 5'h02;
      #10 A = 5'h03;
      #10 A = 5'h04;
      #10 A = 5'h05;
      #10 A = 5'h06;
      #10 A = 5'h07;
      #10 A = 5'h08;
      #10 A = 5'h09;
      #10 A = 5'h0a;
      #10 A = 5'h0b;
      #10 A = 5'h0c;
      #10 A = 5'h0d;
      #10 A = 5'h0e;
      #10 A = 5'h0f;
      #10 A = 5'h10;
      #10 A = 5'h11;
      #10 A = 5'h12;
      #10 A = 5'h13;
      #10 A = 5'h14;
      #10 A = 5'h15;
      #10 A = 5'h16;
      #10 A = 5'h17;
      #10 A = 5'h18;
      #10 A = 5'h19;
      #10 A = 5'h1a;
      #10 A = 5'h1b;
      #10 A = 5'h1c;
      #10 A = 5'h1d;
      #10 A = 5'h1e;
      #10 A = 5'h1f;

      #10 $stop;

    end

endmodule

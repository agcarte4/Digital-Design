module hw4_q1c;

  reg [4:0] A; 
  reg [4:0] B; 
  reg [1:0]C; 
  wire [4:0] S;

  hw4_q1b DUT ( .A(A), .B(B), .C(C), .S(S) );

    initial 
    begin
      
        $monitor( $time, ": A = %4b (%2d), B = %4b (%2d), C = %1b (%2d), S = %5b (%2d) ", A, A, B, B, C, C, S, S );
        for ( C = 0; C < 2; C = C +1)
        for (A = 0; A < 16; A = A + 1)
            for (B = 0; B < 16; B = B + 1)
                #10;
        #10 

        #10 $stop;
    end

endmodule
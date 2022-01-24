module hw4_q2b(
    input [15:0] A, [15:0] B, C,
    output [16:0] S
);

    reg Ca;
    assign Ca = C;
    wire [3:0] SM;
    wire [4:0] Sc;

    genvar i;

  //  for( i = 0; i < 16; i = i + 4 ) begin
  //      hw4_q1b U[i]( A[i+3:i], B[i+3:i], Ca, S[i+4:i]);
  //      assign Ca = S[5];
  //      assign SM = S[i+3:i];
  //      if (SM > 9) begin
  //          hw4_q1b W[i](S[i+3:i], 6, 0, S[i+4:i]);
  //          Ca = 1;
  //      end
  //  end

        hw4_q1b U0( .A(A[3:0]), .B(B[3:0]), .C(Ca), .S(S[4:0]) );
        assign Ca = S[4];
        assign SM = S[3:0];
        hw4_q1b W0( .A(SM), .B(6), .C(0), .S(Sc) );
        
        always @(*) if (SM > 9) begin
            //hw4_q1b W0( .A(S[3:0]), .B(6), .C(0), .S(S[4:0]) );
            assign S[4:0] = Sc;
            Ca = 1;
        end
                
        hw4_q1b U1( .A(A[7:3]), .B(B[7:3]), .C(Ca), .S(S[8:4]) );
        assign Ca = S[8];
        assign SM = S[7:4];
        hw4_q1b W1( .A(SM), .B(6), .C(0), .S(Sc) );
        always @(*) if (SM > 9) begin
            //hw4_q1b W2( .A(S[7:4]), .B(6), .C(0), .S(S[8:4]) );
            assign S[8:4] = Sc;
            Ca = 1;
        end
        
        hw4_q1b U2( .A(A[11:8]), .B(B[11:8]), .C(Ca), .S(S[12:8]) );
        assign Ca = S[12];
        assign SM = S[11:8];
        hw4_q1b W2( .A(SM), .B(6), .C(0), .S(Sc) );
        always @(*) if (SM > 9) begin
            //hw4_q1b W2( .A(S[11:8]), .B(6), .C(0), .S(S[12:8]) );
            assign S[12:8] = Sc;
            Ca = 1;
        end
        
        hw4_q1b U3( .A(A[15:12]), .B(B[15:12]), .C(Ca), .S(S[16:12]) );
        assign Ca = S[16];
        assign SM = S[15:12];
        hw4_q1b W3( .A(SM), .B(6), .C(0), .S(Sc) );
        always @(*) if (SM > 9) begin
            //hw4_q1b W3( .A(S[15:12]), .B(6), .C(0), .S(S[16:12]) );
            assign S[16:12] = Sc;
            Ca = 1;
        end

endmodule
module hw4_q1b(
    input [3:0] A, [3:0] B, C,
    output [4:0] S
);

    wire [3:0] X; 
    wire [3:0] N; 
    wire [4:0] Ca;
    assign Ca[0] = C;

    genvar i;

    for (i=0; i<4; i=i+1) begin
        assign X[i] = A[i] ^ B[i];
        assign N[i] = A[i] && B[i];
        assign Ca[i+1] = N[i] || ( Ca[i] && X[i] );
        assign S[i] = ( Ca[i] ^ X[i] ); 
        if ( i == 3 ) begin
            assign S[i+1] = Ca[i+1];
        end
    end 
endmodule
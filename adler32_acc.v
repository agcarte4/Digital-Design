module adler32_acc(
    input clk,
    input rst_n,
    input [7:0] data,
    output [31:0] checksum
);

    reg [15:0] Anew, Aold;
    reg [15:0] Bnew, Bold;


    always @(posedge clk) begin
        if(!rst_n) begin
            Anew <= 1;
            Bnew <= 0;
            Aold <= 1;
            Bold <= 0;
            end
        else begin
            Anew = ((Aold + data)%65521);
            Bnew = ((Bold + ((Aold + data)%65521))%65521);
            Aold = Anew;
            Bold = Bnew;
            end
    end
    assign checksum = { Bnew, Anew };

endmodule
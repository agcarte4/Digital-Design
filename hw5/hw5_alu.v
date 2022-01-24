module hw5_alu (
    input [15:0] aluin1, [15:0] aluin2, [1:0] alu_control,
    output reg [15:0] aluout, reg alu_carry
);

reg [16:0] sum;

always @(aluin1, aluin2, alu_control) begin
  if (alu_control == 0) begin 
    sum = aluin1 + aluin2;
    assign aluout = sum[15:0];
    assign alu_carry = sum[16];
  end 
  else if (alu_control == 1) begin
    assign aluout = aluin1 &  aluin2;
    assign alu_carry = 0;
  end
  else if (alu_control == 2) begin
    assign aluout = ~aluin1;
    assign alu_carry = 0;
  end       
  else begin 
    assign aluout = 0;
    assign alu_carry = 0;
  end
end

endmodule
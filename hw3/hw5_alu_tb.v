module hw5_alu_tb;

  reg [15:0] aluin1; 
  reg [15:0] aluin2; 
  reg [1:0] alu_control; 
  wire [15:0] aluout;
  wire alu_carry;

  hw5_alu DUT ( .aluin1(aluin1), .aluin2(aluin2), .alu_control(alu_control), .aluout(aluout), .alu_carry(alu_carry) );

    initial 
    begin
      
        $monitor( $time, ": aluin1 = %16b, aluin2 = %16b, alu_control = %2b, aluout = %16b, alu_carry = %1b", aluin1, aluin2, alu_control, aluout, alu_carry);
            aluin1 = 16'h0000, aluin2 = 16'h0001, alu_control = 2'b00;
        #10 aluin1 = 16'hffff, aluin2 = 16'h0001, alu_control = 2'b00;
        #10 aluin1 = 16'h0a00, aluin2 = 16'h0a01, alu_control = 2'b01;
        #10 aluin1 = 16'hffff, aluin2 = 16'hfff0, alu_control = 2'b01;
        #10 aluin1 = 16'hffff, aluin2 = 16'h0000, alu_control = 2'b10;
        #10 aluin1 = 16'hf0f0, aluin2 = 16'habcd, alu_control = 2'b10;
        #10 aluin1 = 16'h0000, aluin2 = 16'h0be1, alu_control = 2'b11;
        #10 aluin1 = 16'hf00f, aluin2 = 16'h0ff1, alu_control = 2'b11;

        #10 $stop;
    end

endmodule
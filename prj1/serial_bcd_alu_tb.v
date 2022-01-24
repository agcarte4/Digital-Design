module serial_bcd_alu_tb;

  reg rst, clk;
  reg en, in;
  reg [19:0] rreg;

  wire result;

  serial_bcd_alu DUT (
    rst, clk, en, in, result
  );

  always #5 clk = ~clk;

  initial
  begin
    $monitor( $time, ": %0h%0h%0h%0h%0h",
      rreg[19:16], rreg[15:12], rreg[11:8],
      rreg[7:4], rreg[3:0]
    );

    clk = 0;
    rst = 1;

    en = 0;
    in = 0;

    #20 rst = 0;
    #50 en = 1; 
        in = 0;//LSB A
    #10 in = 1;//A0
    #10 in = 1;
    #10 in = 0;

    #10 in = 1; //A1
    #10 in = 0;
    #10 in = 1;
    #10 in = 0;
    
    #10 in = 1;//A2
    #10 in = 0;
    #10 in = 0;
    #10 in = 1;
    
    #10 in = 0;//A3
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;//MSB A
    
    #10 in = 0;//LSB B
    #10 in = 0;
    #10 in = 0;//B0
    #10 in = 1;
    
    #10 in = 1;//B1
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;
    
    #10 in = 0;//B2
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;
    
    #10 in = 0;//B3
    #10 in = 0;
    #10 in = 0;
    #10 in = 1;//MSB B
    
    #10 in = 0;
    #10 en = 0;

    #500 en = 1;
        in = 1;
    #10 in = 1;
    #10 in = 0;
    #10 in = 0;
    
    #10 in = 0;
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;
    
    #10 in = 0;
    #10 in = 1;
    #10 in = 0;
    #10 in = 0;
    
    #10 in = 0;
    #10 in = 0;
    #10 in = 1;
    #10 in = 0;
    
    #10 in = 1;
    #10 in = 1;
    #10 in = 1;
    #10 in = 0;
    
    #10 in = 0;
    #10 in = 0;
    #10 in = 1;
    #10 in = 0;
    
    #10 in = 1;
    #10 in = 0;
    #10 in = 0;
    #10 in = 0;
    
    #10 in = 0;
    #10 in = 1;
    #10 in = 0;
    #10 in = 0;
    
    #10 in = 1;
    #10 en = 0;

    #500 $stop;
  end

  always @( posedge clk )
    if( rst )
      rreg <= 0;
    else
      rreg <= { result, rreg[19:1] };

endmodule

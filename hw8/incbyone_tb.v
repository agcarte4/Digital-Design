module incbyone_tb;

  reg        clock;
  reg        reset;
  reg  [3:0] data;
  reg        data_valid;
  wire       data_ready;
  wire [3:0] dp1;
  wire       dp1_valid;
  reg        dp1_ready;

  reg        sent;

  // instantiation of the DUT
  incbyone DUT (
    .clock( clock ),
    .reset( reset ),
    .data( data ),
    .data_valid( data_valid ),
    .data_ready( data_ready ),
    .dp1( dp1 ),
    .dp1_valid( dp1_valid ),
    .dp1_ready( dp1_ready )
  );

  // free-running clock
  always #5 clock = ~clock;

  // these are the initial states for the
  // clock and reset as well as the de-
  // assertion of reset
  initial
  begin
        clock = 0;
        reset = 1;

    #20 reset = 0;
  end

  initial
  begin
    data_valid = 0;
    dp1_ready  = 0;
    data       = 0;

    // give a little wait from start of sim
    repeat( 10 )
      @( posedge clock );

    // send data to the DUT
    data       = 8;
    data_valid = 1;

    // separate register that sets when
    // data_valid and data_ready are high
    wait( sent );
    data_valid = 0;

    // now that the value is sent we'll
    // wait a little while before we send
    // that we're ready to receive
    repeat( 8 )
      @( posedge clock );

    wait( dp1_valid );
      @( posedge clock ) dp1_ready = 1;
    @( posedge clock ) dp1_ready = 0;

    #200 $stop;
  end

  // there isn't a really good way to know
  // when a clock edge occurred and a value
  // was asserted; so we use a clocked
  // process that prints when valid and
  // ready are high at the same clock edge
  always @( posedge clock )
  begin
    if( reset )
      sent <= 0;
    else
      if( data_valid && data_ready ) begin
        $display( $time, ": %10s %10d", "Sent", data );
        sent <= 1;
      end
  end

  // simple process that just looks for a
  // rising clock edge with valid and
  // ready asserted and prints out the
  // value that is on the dp1 output
  always @( posedge clock )
  begin
    if( dp1_valid && dp1_ready )
      $display( $time, ": %10s %10d", "Received", dp1 );
  end

endmodule

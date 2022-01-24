module incbyone (
    input clock, reset,
    input [3:0] data,
    input data_valid,
    output data_ready,
    output [3:0] dp1,
    output dp1_valid,
    input dp1_ready
);
controller ct (clock, reset, data_valid, data_ready, dp1_valid, dp1_ready);
datapath dp (clock, reset, data, data_valid, dp1);
endmodule

module controller (
    input clock, reset,
    input data_valid,
    output reg data_ready,
    output reg dp1_valid,
    input dp1_ready
);

localparam ST_WAITING = 0;
localparam ST_DONE    = 1;

reg cstate, nstate;

always @( posedge clock )
if( reset )
  cstate <= ST_WAITING;
else 
  cstate <= nstate;

always @*
  case( cstate )
    ST_WAITING : begin
        nstate = data_valid ? ST_DONE : ST_WAITING;
        data_ready = data_valid ? 1 : 0;
        dp1_valid = 0;
    end
    ST_DONE : begin
        nstate = dp1_ready ? ST_WAITING : ST_DONE;
        dp1_valid = 1;
        data_ready = 0;
    end
  endcase

endmodule

module datapath (
    input clock, reset,
    input [3:0] data,
    input data_valid,
    output [3:0] dp1
);
  
  reg [3:0] datap1;

  always @( posedge clock )  
    if( reset )
       datap1 <= 0;
    else
      if ( data_valid )
        datap1 <= (data + 1);
      else 
        datap1 <= datap1;
    
  assign dp1 = datap1;


endmodule
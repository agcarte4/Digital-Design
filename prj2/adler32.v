module adler32 (
    input rst_n, clock, size_valid,
    input [31:0] size,
    input data_start,
    input [7:0] data,
    output checksum_valid,
    output [31:0] checksum
);

wire load_size, load_data, counter;

datapath dp (clock, rst_n, size, data, load_size, load_data, 
            counter, checksum);

controller ct (clock, rst_n, size_valid, data_start, counter,
            load_size, load_data, checksum_valid);

endmodule


module datapath(
    input clock, rst_n,
    input [31:0] size,
    input [7:0] data,
    input load_size, load_data,
    output counter,
    output [31:0] checksum
);

    reg [15:0] A;
    reg [15:0] B;
    reg [31:0] S;
    wire [15:0] modulo_add_A, modulo_add_B;


    always @(posedge clock) begin
        if(!rst_n) begin
            A <= 1;
            B <= 0;
            S <= 0;
            end
        else begin
            if(load_size)    //this if/else controls the counter given 
                S <= size;        //by size
            else if (load_data)
                S <= S - 1;    //decrement the size count

            if(load_data) begin           //these statements control the datapath for A & B
                if((A + data) >= 65521)
                    A <= A + data - 65521;
                else    
                    A <= A + data;
                if((B + A + data) >= 65521)
                    B <= B + A + data - 65521;
                else    
                    B <= B + A + data;
                end
            else begin
                A <= A;
                B <= B;
                end
            end
        end

    assign counter = (S == 0) ? 1 : 0;
    assign checksum = { B, A };   //assign the values to the checksum

    modulo_sum sum_A (
      A, {8'h00, data}, modulo_add_A );

    modulo_sum sum_B (
      B, modulo_add_A, modulo_add_B );

endmodule


module controller(
    input clock, rst_n, 
    input size_valid, data_start,
    input counter,
    output reg load_size, load_data,
    output reg checksum_valid
);
  reg [2:0] cstate, nstate;
  localparam ST_WAIT = 2'b00;
  localparam ST_LOAD = 2'b01;
  localparam ST_COMPUTE = 2'b10;

  always @( posedge clock )
    if( !rst_n )
      cstate <= ST_WAIT;
    else
      cstate <= nstate;

  always @*
    case( cstate )
      ST_WAIT : begin                               //reset state, waits for size_valid
        nstate = size_valid ? ST_LOAD : ST_WAIT;
        load_size = size_valid ? 1 : 0;
        load_data = 0;
        checksum_valid = 0;
      end

      ST_LOAD : begin                               //load state, waits for data_start, then delays load_data by 1 cycle
        nstate = data_start ? ST_COMPUTE : ST_LOAD;
        //load_data = data_start ? 1 : 0;
        load_size = 0;
        checksum_valid = 0;
      end

      ST_COMPUTE : begin
        nstate = counter ? ST_WAIT : ST_COMPUTE;    //data compute state, loads data and starts the checksum process
        load_data = counter ? 0 : 1;                //continue adding new data until counter is 0
        checksum_valid = counter ? 1 : 0;
        load_size = 0;
      end

    endcase

endmodule

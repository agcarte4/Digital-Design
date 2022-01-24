module piso (
  input rst, clk,
  input ld,
  input [19:0] in,
  output f
);
 
  wire [3:0] q;

  piso_msb byte4 (rst, clk, ld, in[19:16], q[3]);
  piso_reg byte3 (rst, clk, ld, q[3], in[15:12], q[2]);
  piso_reg byte2 (rst, clk, ld, q[2], in[11:8], q[1]);
  piso_reg byte1 (rst, clk, ld, q[1], in[7:4], q[0]);
  piso_reg byte0 (rst, clk, ld, q[0], in[3:0], f);

endmodule

module piso_msb (
  input rst, clk,
  input ld, 
  input [3:0] in,
  output f
);

wire [3:0] d;
wire [3:0] q;

assign d[3] = ld ? in[3] : 0;
assign d[2] = ld ? in[2] : q[3];
assign d[1] = ld ? in[1] : q[2];
assign d[0] = ld ? in[0] : q[1];

dff bit3 (rst, clk, d[3], q[3]);
dff bit2 (rst, clk, d[2], q[2]);
dff bit1 (rst, clk, d[1], q[1]);
dff bit0 (rst, clk, d[0], q[0]);
assign f = q[0]; 

endmodule

module piso_reg (
  input rst, clk,
  input ld, 
  input prev,
  input [3:0] in,
  output f
);

wire [3:0] d;
wire [3:0] q;

assign d[3] = ld ? in[3] : prev;
assign d[2] = ld ? in[2] : q[3];
assign d[1] = ld ? in[1] : q[2];
assign d[0] = ld ? in[0] : q[1];

dff bit3 (rst, clk, d[3], q[3]);
dff bit2 (rst, clk, d[2], q[2]);
dff bit1 (rst, clk, d[1], q[1]);
dff bit0 (rst, clk, d[0], q[0]);
assign f = q[0]; 


endmodule

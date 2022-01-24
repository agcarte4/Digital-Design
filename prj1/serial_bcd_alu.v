module serial_bcd_alu(
    input rst, clk,
    input en, in,
    output result
);

  wire [15:0] bcd_A;
  wire [15:0] bcd_B;
  wire [19:0] sum;
  wire ctrl;
  wire load;
  wire sipo_ld;
  wire piso_ld;
  wire not_en;

  dff U4 (rst, clk, en, load);

  assign sipo_ld = en ? clk : 0;

  not U5 (not_en, en);
  and U6 (piso_ld, not_en, load);

  sipo U0 (rst, sipo_ld, in, bcd_A, bcd_B, ctrl);
  hw6_alu U1 (sum, ctrl, bcd_A, bcd_B);
  piso U3 (rst, clk, piso_ld, sum, result);

endmodule


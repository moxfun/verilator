// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2013 by Wilson Snyder.

module t (/*AUTOARG*/);

   typedef struct packed {
      logic [3:2] a;
      logic [5:4][3:2] b;
   } ab_t;
   typedef ab_t [7:6] c_t;  // array of structs
   typedef struct packed {
      c_t [17:16] d;
   } e_t;

`define check(got,expec) do if ((got) != (expec)) begin $display("Line%0d:  Got %b Exp %b\n", `__LINE__, (got), (expec)); $stop; end while(0);

   initial begin
      e_t e;
      if ($bits(ab_t)!=6) $stop;
      if ($bits(c_t)!=12) $stop;
      if ($bits(e_t)!=24) $stop;
      e =       24'b101101010111010110101010;
      `check(e, 24'b101101010111010110101010);
      e.d[17] = 12'b111110011011;
      `check(e, 24'b111110011011010110101010);
      e.d[16][6] =                 6'b010101;
      `check(e, 24'b111110011011010110010101);
      e.d[16][6].b[5] =            2'b10;
      `check(e, 24'b111110011011010110011001);
      e.d[16][6].b[5][2] =           1'b1;
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule

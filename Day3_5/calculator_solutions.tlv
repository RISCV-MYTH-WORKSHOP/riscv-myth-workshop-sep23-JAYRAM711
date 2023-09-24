\m5_TLV_version 1d: tl-x.org
\m5
   
   // =================================================
   // Welcome!  New to Makerchip? Try the "Learn" menu.
   // =================================================
   
   //use(m5-1.0)   /// uncomment to use M5 macro library.
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   |calc
      @1
         $reset = *reset;
         $valid = $reset ? 32'b0 : (>>1$valid + 1 );
         $rst[31:0] = ($valid | $reset);
      ?$valid
         @1   
            
            $val1[31:0] = >>2$out;
            $val2[31:0] = $rand2[3:0];
            $out[31:0] = $reset ? 32'b0 : $op[0] ? $val1[31:0]  + $val2[31:0] 
                                             : $op[1] ? $val1[31:0] - $vel2[31:0]
                                                     :$op[2] ? $val1[31:0] * $val2[31:0]
                                                              : $op[3] ? $val1[31:0] / $val2[31:0]
                                                                        : >>2$mem[31:0];
            $mem[31:0] = $reset ? 32'b0 : $op[0] ? >>2$mem[31:0] : >>2$out; 
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

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
      @0
         $reset = *reset;
         $valid = $reset ? 0 : (>>1$valid + 1);
         
      ?$valid
         @1
            $val1[31:0] = >>2$out;
            //$val1[31:0] = $rand1[3:0];
            $val2[31:0] = $rand2[3:0];
            $op[2:0] = $rand3[2:0];
            
            //Basic Arithmetic Operations
            $sum[31:0]   = $val1 + $val2;
            $sub[31:0]  = $val1 - $val2;
            $mul[31:0]  = $val1 * $val2;
            $div[31:0]  = $val1 / $val2;
         @2
            //Compute result depending on opcode 
            $out[31:0] = ($op[2:0] == 3'b000) ? $sum[31:0] :
                         ($op[2:0] == 3'b001) ? $sub[31:0] :
                         ($op[2:0] == 3'b010) ? $mul[31:0] :
                         ($op[2:0] == 3'b011) ? $div[31:0] :
                         ($op[2:0] == 3'b100) ? >>2$mem[31:0] : 32'b0;
                         
            //Hold the previous result
            $mem[31:0] = ($op[2:0] == 3'b100) ? >>2$mem[31:0] :
                         ($op[2:0] == 3'b101) ? >>2$out[31:0] : >>2$mem[31:0];
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

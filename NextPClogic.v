`timescale 1ns / 1ps

module NextPClogic(NextPC, CurrentPC, SignExtImm64,
		   Branch, ALUZero, Uncondbranch);
   input [63:0] CurrentPC, SignExtImm64;
   input 	Branch, ALUZero, Uncondbranch;
   output reg [63:0] NextPC;

   //assign wire that controls multiplexer
   wire muxSel;
   assign muxSel = (Branch & ALUZero) | Uncondbranch;

   always @(*)
     if (muxSel) //multiplexer logic
       NextPC <= #3 CurrentPC + (SignExtImm64 << 2);
     else
       NextPC <= #2 CurrentPC + 64'h4;
   
endmodule // NextPClogic

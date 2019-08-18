`timescale 1ns / 1ps

module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
   output [63:0] BusA, BusB;
   input [63:0] BusW;
   input [4:0] RW, RA, RB;
   input Clk, RegWr;
   reg [63:0] registers [31:0];

   always @ (Clk)
     registers[31] <= 64'h0;
   
   assign #2 BusA = registers[RA];
   assign #2 BusB = registers[RB];
      
   always @ (negedge Clk)
     begin
      if(RegWr)
	if (RW != 5'd31)
	  registers[RW] <= #3 BusW;
     end
endmodule


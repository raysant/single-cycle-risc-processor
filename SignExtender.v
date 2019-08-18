`timescale 1ns / 1ps
`define B     6'b000101
`define BL    6'b100101
`define Bcond 8'b01010100
`define CBZ   8'b10110100
`define CBNZ  8'b10110101
`define ORI   10'b1011001000
`define LSL   11'b11010011011

module SignExtender(BusImm, Imm32);
   output reg [63:0] BusImm;
   input [31:0]      Imm32;
   reg 		     extBit;
   
   always @(*)
     if ((Imm32[31:26] == `B) | (Imm32[31:26] == `BL))
       begin
	  extBit = Imm32[25];
	  BusImm = {{38{extBit}}, Imm32[25:0]};
       end
     else if ((Imm32[31:24] == `CBZ) | (Imm32[31:24] == `CBNZ) | (Imm32[31:24] == `Bcond))
       begin
	  extBit = Imm32[23];
	  BusImm = {{45{extBit}}, Imm32[23:5]};
       end
     else if (Imm32[31:22] == `ORI)
       begin
	  extBit = 1'b0;
	  BusImm = {{52{extBit}}, Imm32[21:10]};
       end
     else if (Imm32[31:21] == `LSL)
       begin
	  extBit = 1'b0;
	  BusImm = {{58{extBit}}, Imm32[15:10]};
       end
     else
       begin
	  extBit = Imm32[20];
	  BusImm = {{55{extBit}}, Imm32[20:12]};
       end
endmodule // SignExtender













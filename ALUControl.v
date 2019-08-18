`timescale 1ns / 1ps
`define ADD 11'b10001011000
`define SUB 11'b11001011000
`define AND 11'b10001010000
`define ORR 11'b10101010000
`define ORI 11'b1011001000

module ALUControl(ALUCtrl, ALUop, Opcode);
   input [1:0] ALUop;
   input [10:0] Opcode;
   output reg [3:0] ALUCtrl;

   always @(ALUop, Opcode)
     casez (ALUop)
       2'b00: ALUCtrl = #2 4'b0010; // output for LDUR/STUR operation
       2'b01: ALUCtrl = #2 4'b0111; // output for CBZ operation
       2'b10: // output for R-type
	 begin
	    if (Opcode == `ADD)
	      ALUCtrl = #2 4'b0010;
	    else if (Opcode == `SUB)
	      ALUCtrl = #2 4'b0110;
	    else if (Opcode == `AND)
	      ALUCtrl = #2 4'b0000;
	    else if ((Opcode == `ORR) | (Opcode[10:1] == `ORI))
	      begin
		 ALUCtrl = #2 4'b0001;
	      end
	    else
	      ALUCtrl = #2 4'b0011;
	 end
     endcase
endmodule // ALUControl

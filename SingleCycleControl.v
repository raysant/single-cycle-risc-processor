`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: 
// Module Name:    SingleCycleControl 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`define LDUROPCODE 11'b11111000010
`define STUROPCODE 11'b11111000000
`define ADDOPCODE  11'b10001011000
`define SUBOPCODE  11'b11001011000
`define ANDOPCODE  11'b10001010000
`define ORROPCODE  11'b10101010000
`define CBZOPCODE  11'b10110100???
`define BOPCODE    11'b000101?????
`define LSLOPCODE  11'b11010011011
`define ORIOPCODE  11'b1011001000?
/* Note, the "?"'s in CBZ and B indicate don't care in a casez */

module SingleCycleControl(Reg2Loc, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Uncondbranch, ALUOp, Opcode);
   input [10:0] Opcode;
   output 	Reg2Loc;
   output 	ALUSrc;
   output 	MemToReg;
   output 	RegWrite;
   output 	MemRead;
   output 	MemWrite;
   output 	Branch;
   output 	Uncondbranch;
   
   output [1:0] ALUOp;
   
   reg 		Reg2Loc, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Uncondbranch;
   reg [1:0] 	ALUOp;
   always @ (Opcode) begin
      casez(Opcode)
        `LDUROPCODE: begin
           Reg2Loc <= #2 1'bx;
           Uncondbranch <= #2 1'b0;
           Branch <= #2 1'b0;
           MemRead <= #2 1'b1;
           MemToReg <= #2 1'b1;
           MemWrite <= #2 1'b0;
           ALUSrc <= #2 1'b1;
           RegWrite <= #2 1'b1;
           ALUOp <= #2 2'b00;
        end // case: `LDUROPCODE
	
        `STUROPCODE: begin
          Reg2Loc <= #2 1'b1;
           Uncondbranch <= #2 1'b0;
           Branch <= #2 1'b0;
           MemRead <= #2 1'b0;
           MemToReg <= #2 1'bx;
           MemWrite <= #2 1'b1;
           ALUSrc <= #2 1'b1;
           RegWrite <= #2 1'b0;
           ALUOp <= #2 2'b00;
        end // case: `STUROPCODE
	
	`ADDOPCODE: begin
           Reg2Loc <= #2 1'b0;
           Uncondbranch <= #2 1'b0;
           Branch <= #2 1'b0;
           MemRead <= #2 1'b0;
           MemToReg <= #2 1'b0;
           MemWrite <= #2 1'b0;
           ALUSrc <= #2 1'b0;
           RegWrite <= #2 1'b1;
           ALUOp <= #2 2'b10;
        end // case: `ADDOPCODE

	`SUBOPCODE: begin
           Reg2Loc <= #2 1'b0;
           Uncondbranch <= #2 1'b0;
           Branch <= #2 1'b0;
           MemRead <= #2 1'b0;
           MemToReg <= #2 1'b0;
           MemWrite <= #2 1'b0;
           ALUSrc <= #2 1'b0;
           RegWrite <= #2 1'b1;
           ALUOp <= #2 2'b10;
        end // case: `SUBOPCODE

	`ANDOPCODE: begin
           Reg2Loc <= #2 1'b0;
           Uncondbranch <= #2 1'b0;
           Branch <= #2 1'b0;
           MemRead <= #2 1'b0;
           MemToReg <= #2 1'b0;
           MemWrite <= #2 1'b0;
           ALUSrc <= #2 1'b0;
           RegWrite <= #2 1'b1;
           ALUOp <= #2 2'b10;
        end // case: `ANDOPCODE

	`ORROPCODE: begin
           Reg2Loc <= #2 1'b0;
           Uncondbranch <= #2 1'b0;
           Branch <= #2 1'b0;
           MemRead <= #2 1'b0;
           MemToReg <= #2 1'b0;
           MemWrite <= #2 1'b0;
           ALUSrc <= #2 1'b0;
           RegWrite <= #2 1'b1;
           ALUOp <= #2 2'b10;
        end // case: `ORROPCODE

        `ORIOPCODE: begin	   
           Reg2Loc <= #2 1'b0;
           Uncondbranch <= #2 1'b0;
           Branch <= #2 1'b0;
           MemRead <= #2 1'b0;
           MemToReg <= #2 1'b0;
           MemWrite <= #2 1'b0;
           ALUSrc <= #2 1'b1;
           RegWrite <= #2 1'b1;
           ALUOp <= #2 2'b10;
        end // case: `ORIOPCODE

	`LSLOPCODE: begin
           Reg2Loc <= #2 1'b0;
           Uncondbranch <= #2 1'b0;
           Branch <= #2 1'b0;
           MemRead <= #2 1'b0;
           MemToReg <= #2 1'b0;
           MemWrite <= #2 1'b0;
           ALUSrc <= #2 1'b1;
           RegWrite <= #2 1'b1;
           ALUOp <= #2 2'b10;
        end // case: `LSLOPCODE

	`CBZOPCODE: begin
           Reg2Loc <= #2 1'b1;
           Uncondbranch <= #2 1'b0;
           Branch <= #2 1'b1;
           MemRead <= #2 1'b0;
           MemToReg <= #2 1'bx;
           MemWrite <= #2 1'b0;
           ALUSrc <= #2 1'b0;
           RegWrite <= #2 1'b0;
           ALUOp <= #2 2'b01;
        end // case: `CBZOPCODE

	`BOPCODE: begin
           Reg2Loc <= #2 1'bx;
           Uncondbranch <= #2 1'b1;
           Branch <= #2 1'b0;
           MemRead <= #2 1'b0;
           MemToReg <= #2 1'bx;
           MemWrite <= #2 1'b0;
           ALUSrc <= #2 1'bx;
           RegWrite <= #2 1'b0;
           ALUOp <= #2 2'bxx;
        end // case: `BOPCODE
	
        default: begin
           Reg2Loc <= #2 1'bx;
           ALUSrc <= #2 1'bx;
           MemToReg <= #2 1'bx;
           RegWrite <= #2 1'bx;
           MemRead <= #2 1'bx;
           MemWrite <= #2 1'bx;
           Branch <= #2 1'bx;
           ALUOp <= #2 2'bxx;
        end
      endcase
   end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Design Name: 
// Module Name:    SingleCycleProc 
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
module SingleCycleProc(CLK, Reset_L, startPC, currentPC, dMemOut);
   input CLK;
   input Reset_L;
   input [63:0] startPC;
   output [63:0] currentPC;
   output [63:0] dMemOut;
   
   //PC Logic
   wire [63:0] 	 nextPC;
   reg [63:0] 	 currentPC;
   
   //Instruction Decode
   wire [31:0] 	 currentInstruction;
   wire [10:0] 	 opcode;
   wire [4:0] 	 rm,rn,rd;
   wire [5:0] 	 shamt;

   // Decoding instruction fields
   assign {opcode, rm, shamt, rn, rd} = currentInstruction;
   
   //Register wires
   wire [63:0] 	 busA, busB, busW; //buses for inputs and
   //outputs of regfile
   wire [4:0] 	 rB; // Used to attach output of
   // Reg2Loc mux to B input register
   // index input
   
   //Control Logic Wires
   wire 	 Reg2Loc, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Uncondbranch;
   wire [1:0] 	 ALUOp;
   wire [3:0] 	 ALUCtrl;
   
   //ALU Wires
   wire [63:0] 	 signExtImm64, ALUImmRegChoice;
   wire [63:0] 	 ALUResult;
   wire 	 ALUZero;
   
   //Data Memory Wires
   wire [63:0] 	 dMemOut;

   //Instruction Memory
   InstructionMemory instrMem(currentInstruction, currentPC);	
   
   //PC Logic
   NextPClogic next(nextPC, currentPC, signExtImm64, Branch, ALUZero, Uncondbranch);
   always @ (negedge CLK, negedge Reset_L) begin
      if(~Reset_L)
	currentPC = startPC;
      else
	currentPC = nextPC;
   end
   
   //Control
   SingleCycleControl control(Reg2Loc, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Uncondbranch, ALUOp, opcode);
   
   //Register file
   /*create the Reg2Loc mux*/
   assign #2 rB = Reg2Loc ? rd : rm;

   RegisterFile registers(busA, busB, busW, rn, rB, rd, RegWrite, CLK);
   
   //Sign Extender
   /*instantiate your sign extender*/
   SignExtender signext(signExtImm64, currentInstruction);
   
   //ALU
   ALUControl ALUCont(ALUCtrl, ALUOp, opcode);
   assign #2 ALUImmRegChoice = ALUSrc ? signExtImm64 : busB;
   ALU mainALU(ALUResult, ALUZero, busA, ALUImmRegChoice, ALUCtrl);
   
   //Data Memory
   DataMemory data(dMemOut, ALUResult, busB, MemRead, MemWrite, CLK);
   /*create MemToReg mux */
   assign #2 busW = MemToReg ? dMemOut : ALUResult;
   
endmodule

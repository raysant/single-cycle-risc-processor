# Single-Cycle RISC Processor
A single-cycle processor written in verilog, with test bench included. Implements a portion of the 64-bit LEGv8 instruction set (an ARM-like instruction set).

Instructions implemented:
- Data storage and retrieval instructions: `LDUR` and `STUR`
- Arithmetic and logic instructions: `ADD`, `SUB`, `AND`, `ORR`, `ORI`,	`LSR`, and `LSL`
- Branch and conditional branch instructions: `B` and `CBZ`
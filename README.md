# Team-ExceptioNull
Comp Arch Final Project: 8 bit computer

Memory Allocation: 8 by 256 bits
Programs have:

2^6 = 64 lines text and reserved available

2^6 = 64 lines data available


Parts: PC, Instruction Memory, Registers, ALU, Data Memory


Modules:
Finte State Machine: Fetch, Decode, Execute, Memread, Writeback

PC   - testbench not working
Instruction Memory - testbench working but it needs memory to test (because instruction mem reads the address and reads from mem)
Register Files - testbench working
ALU - testbench working
control unit - testbench working
Data Memory - testbench working for write, read needs an input/memory to test (idk if its actually loading from mem, same problem as instruction mem)

Compiler Program needed

Module needed which loads binary (compiled) code into RAM before Finite statemachine starts and reads from those instructions

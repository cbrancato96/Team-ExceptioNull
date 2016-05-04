module instruction_mem (
instruction_address,
instruction_data);

input [7:0] instruction_address;
output [7:0] instruction_data;  

reg [7:0] instruction_mem [0:63];

parameter INSTRUCTIONS = "CompiledBinary.bin";
  
assign instruction_data = instruction_mem[instruction_address];

initial begin
  $readmemb(INSTRUCTIONS, instruction_mem);
end

endmodule




//Testbench
module test();
  reg [7:0] instruction_address;
  wire [7:0] instruction_data;
  
  instruction_mem INSTRUCTION_MEM(
    .instruction_address(instruction_address),
    .instruction_data(instruction_data));
 
  initial begin
	instruction_address = 8'b0;
    $display("instruction_address=%b,instruction_data=%b",instruction_address, instruction_data);

$monitor("instruction_address=%b,instruction_data=%b",instruction_address, instruction_data);
  end

endmodule

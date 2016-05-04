module instruction_mem (
instruction_address,
instruction_data);

input [7:0] instruction_address;
output [7:0] instruction_data;  


reg [7:0] instruction_mem [255:0];
  
assign instruction_data = instruction_mem[instruction_address];
  
endmodule

//Loading into Memory Module
module  memory();
  reg [7:0] instruction_memory [255:0];

initial begin
  $readmemh("CompiledBinary.txt", instruction_memory);
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

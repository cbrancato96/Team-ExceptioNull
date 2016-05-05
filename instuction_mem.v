module instruction_mem (
instruction_address,
instruction_data,
clk);

input clk;
input [7:0] instruction_address;
output [7:0] instruction_data;  

  reg [7:0] instruction_mem [0:63];
  reg [7:0] instruction_data;
  
parameter INSTRUCTIONS = "instMem.bin";
  
  always @ (posedge clk) begin
	instruction_data <= instruction_mem[instruction_address];
  end 
  
initial begin
  $readmemb(INSTRUCTIONS, instruction_mem);
end

endmodule

//Testbench
module test();
  reg [7:0] instruction_address;
  reg clk;
  wire [7:0] instruction_data;
  
  instruction_mem INSTRUCTION_MEM(
    .instruction_address(instruction_address),
    .instruction_data(instruction_data),
    .clk(clk)
  );
 
  initial begin
	instruction_address = 8'b0;
    clk = 0;
    $display("instruction_address=%b,instruction_data=%b, clk=%b",instruction_address, instruction_data, clk);

    $monitor("instruction_address=%b,instruction_data=%b, clk=%b",instruction_address, instruction_data, clk);
     #10 clk = 1;
  end

endmodule

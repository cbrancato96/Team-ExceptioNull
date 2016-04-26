// Code your design here
module program_counter(
  clk,
  pc_control,
  jump_offset,
  pc);

  input clk;
  input pc_control;
  input [7:0] jump_offset;

  output [7:0] pc;

  wire [7:0] pc_update;
  wire [7:0] offset;
  
  assign offset = pc_control & jump_offset;
  assign pc_update = pc + 1 + offset;
  
  always @(clk)
    begin
    if (clk == 1) begin
  		assign pc = pc_update;
    end
  end
  

endmodule


// Code your testbench here
// or browse Examples
module test;
  
  reg clk;
  reg pc_control;
  reg [7:0] jump_offset;
  reg [7:0] pc;
  wire [7:0] pc_update;
  
  initial begin
    $display("Initial conditions");
     #5 clk = 1;
    pc_control = 8'b0;
    jump_offset = 8'b11111111;
    pc = 0;
    $monitor("pc:%b, pc_update=%b, pc_control:%b, jump_offset=%b", pc, pc_update, pc_control, jump_offset);
    #10 clk = ~clk;
  end

endmodule

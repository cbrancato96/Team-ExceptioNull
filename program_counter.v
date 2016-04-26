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
  
  assign offset = 8{pc_controll} & jump_offset;
  assign pc_update = pc + 1 + offset;
  
  always
  begin
    pc <= pc_update;
  end

endmodule

// Testbench
module test;
  
  reg clk;
  reg pc_control;
  reg [7:0] jump_offset;
  reg [7:0] pc;
  wire [7:0] pc_update;
  
  initial begin
    clk = 0;
    pc_control = 0;
    jump_offset = 1111111;
    pc = 0;
    $monitor("pc:%b",pc_update, pc);
    $display("Initial conditions");
    #5 clk = 1;
  end
  
  task monitor;
    begin
      $monitor("pc:%b pc_control:%b",pc_update, pc, pc_control);
    end
  endtask
  

endmodule

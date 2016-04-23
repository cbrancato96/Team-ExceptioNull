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

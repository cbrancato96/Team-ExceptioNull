module program_counter(
  clk,
  pc_control,
  jump_offset,
  pc_update,
  pc);

  input clk;
  input [7:0] pc_control;
  input [7:0] jump_offset;
  
  output [7:0] pc;
  output[7:0] pc_update;
  
  reg [7:0] pc;
  wire [7:0] pc_update;
  wire [7:0] offset;
  
  initial begin
    pc = 8'b0;
  end
  
  assign pc_update = pc + 1 + (pc_control & jump_offset);
  
  always @ (posedge clk)
    begin 
      if (clk) begin 
  	    pc <= pc_update;
      end
  end 
endmodule

////////////////////////

module test;
  
  reg clk;
  reg [7:0] pc_control;
  reg [7:0] jump_offset;
  wire [7:0] pc;
  wire [7:0] pc_update;
  
   program_counter PROGRAM_COUNTER(
    .clk(clk),
    .pc_control(pc_control),
    .jump_offset(jump_offset),
    .pc_update(pc_update),
    .pc(pc));
    
  initial begin
    $display("Initial conditions");
    clk = 0;
    pc_control = 8'b0;
    jump_offset = 8'b11;
    display;
    
    clk = 1;
    display;
    
    clk = 0;
    display;
    
    pc_control = 8'b11111111;
    clk = 1;
    display;
    
    pc_control = 8'b0;
    clk = 0;
    display;
    
    clk = 1;
    display;
  end
  
 
  
 task display;
   #1 $display("pc:%b, pc_update=%b, pc_control:%b, jump_offset=%b, clk=%b", pc, pc_update, pc_control, jump_offset, clk);
  endtask
  
  
endmodule

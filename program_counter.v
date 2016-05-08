module program_counter(
  clk,
  pc_control,
  jump_offset,
  pc,
startup);

  input clk;
  input [7:0] pc_control;
  input [7:0] jump_offset;
  input startup;
  wire [7:0] pc_update;
  output [7:0] pc;
  
  reg [7:0] pc;
  wire [7:0] offset;
  
  assign pc_update = pc + 1 + (pc_control & jump_offset);

  
  always @ (posedge clk)
    begin 
      if (startup == 1) begin 
        pc = 8'b0;
    	end else
          pc <= pc_update;
  end 
endmodule

/*
//Testbench
module test;
  
  reg clk;
  reg [7:0] pc_control;
  reg [7:0] jump_offset;
  reg startup;
  reg [7:0] pc;
  
   program_counter PROGRAM_COUNTER(
    .clk(clk),
    .pc_control(pc_control),
    .jump_offset(jump_offset),
    .pc(pc),
    .startup(startup));
    
  initial begin
    $display("Initial conditions");
    startup = 1;
    clk = 0;
    pc_control = 8'b0;
    jump_offset = 8'b11;
    display;
    
    #10 startup = 1;
    clk = 1;
    display;
    
    #10 startup = 0;
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
   #1 $display("pc:%b, pc_control:%b, jump_offset=%b, clk=%b, startup=%b", pc, pc_control, jump_offset, clk, startup);
  endtask
endmodule
*/

// Code your design here
module control_unit(
  instruction,
  jump,
  mem_w_en,
  reg_w_en,
  sel_w_source);

  input [7:0] instruction;
 
  output [7:0] jump;
  output mem_w_en;
  output reg_w_en;
  output sel_w_source;
  
  wire [3:0] opcode;
  wire [7:0] instruction;
  
  reg [7:0] jump;
  reg mem_w_en;
  reg reg_w_en;
  reg sel_w_source;
  

  assign opcode = instruction[7:4];
  
  always @(instruction) 
    begin
      
    if (opcode == 4'b0000) begin   //Move
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = instruction[3:2]; 
      jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 0;
      end else
        
    if (op == 4'b0001) begin   //Add
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = 2'b0; 
      jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 0;
      end else 
        
    if (op == 4'b0010) begin   //And
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = 2'b0; 
      jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 0;
      end else
        
    if (op == 4'b0011) begin//Not
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = instruction[3:2]; 
      jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 0;
      end else
        
    if (op == 4'b0100) begin   //Nor
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = 2'b0; 
      jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 0;
  	  end else 
        
    if (op == 4'b0101) begin   //Slt: Set Less Than
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = 2'b0; 
      jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 0;
      end else
        
    if (op == 4'b0110) begin    //Sll: Shift Left Logical
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = instruction[3:2]; 
      jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 0;
      end else
        
    if (op == 4'b0111) begin   //Srl: Shift Right Logical
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = instruction[3:2]; 
      jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 0;
      end else 
    
    if (op == 4'b1000) begin   //J: Jump
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = instruction[3:2]; 
      jump = 8'b11111111;
      mem_w_en = 0;
      reg_w_en = 0;
      sel_w_source = 0;
  	  end else 
        
    if (op == 4'b1001) begin    //Jal: Jump and link
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = instruction[3:2];
      jump = 8'b11111111;
      mem_w_en = 0;
      reg_w_en = 0;
      sel_w_source = 0;
  	  end else
        
    if (op == 4'b1010) begin   //lw: load word
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = 2'b0;
      jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 1;
      end else 
        
    if (op == 4'b1011) begin  //sw: store word
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = 2'b0;
      jump = 8'b0;
      mem_w_en = 1;
      reg_w_en = 0;
      sel_w_source = 0;
      end else
        
    if (op == 4'b1100) begin   //beq: branch if equal
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_2 = 2'b0;
      reg_addr_w = 2'b0;
      jump = 8'b11111111;
      mem_w_en = 0;
      reg_w_en = 0;
      sel_w_source = 0;
      end else
        
    if (op == 4'b1101) begin   //bne: branch not equal
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = 2'b0;
      jump = 8'b11111111;
      mem_w_en = 0;
      reg_w_en = 0;
      sel_w_source = 0;
      end else
        
    if (op == 4'b1110) begin  //addi: add immediate
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = instruction[3:2];
      jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 0;
  	  end else 
        
    if (op == 4'b1111) begin //li: load immediate
      jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 0;;
      end
    end   
    
endmodule

////////////////////////////////////
// Code your testbench here
// or browse Examples

module test();
  
  wire [2:0] alu_control;
  reg alu_zero;
  reg branch;
  reg alu_src;
  reg wren_reg;
  reg wren_data;
  reg datamem_toreg;
  
  wire [3:0] op;
  reg [7:0] instruction;
  
  control_unit CONTROL_UNIT(
    .alu_control(alu_control),
    .op(op),
    .instruction(instruction),
    .alu_zero(alu_zero),
    .branch(branch),
    .alu_src(alu_src),
    .wren_reg(wren_reg),
    .wren_data(wren_data),
    .datamem_toreg(datamem_toreg));
 
  initial begin
    instruction = 8'b0;
    #10ns;
    $monitor ("op=%b,	instruction=%b,	alu_control=%b,	branch=%b,	alu_src=%b,	wren_reg=%b,	wren_data=%b,	datamem_toreg=%b",op,instruction,alu_control,branch,alu_src,wren_reg,wren_data,datamem_toreg);
    #10 instruction = 8'b11101111;
  end

endmodule


module cpu()
  
  //Declarations
  
  wire [7:0] pc;
  wire [7:0] instruction;
  
  wire [1:0] reg_addr_0; // Address of Source Reg 0
  wire [1:0] reg_addr_1; // Address of Source Reg 1
  wire [1:0] reg_addr_w; // Address of Destination Reg
  
  wire [7:0] reg_data0; // Data from Reg 0
  wire [7:0] reg_data1; // Data from Reg 1
  wire [7:0] op1; // Reg 1 Or Immidieate Data
  wire [7:0] reg_wdata; // Data to Destination Reg
  
  
  wire [3:0] opcode; //Control unit outputs
  wire branch;
  wire sel_op1;
  wire sel_w_loc;
  wire sel_w_result;
  wire mem_w_en;
  wire reg_w_en;
  wire stack_w_en;
  wire stack_r_en;
  
  wire [7:0] alu_result;
  wire [7:0] mem_r_result;

  wire [1:0] imm_data;
  wire [7:0] extended_imm;

  assign imm_data = instruction[1:0];
  assign rs = instruction[3:2];
  assign rt = instruction[1:0];
  
  // Operation Instantiation
  instruction_mem instMem (.instruction_address(pc), .instruction_data(instruction));
  
  control_unit ctrl (.instruction(instruction), .op(opcode), .imm_data);
  
  reg_file regs (.raddr0(reg_addr_0), .raddr1(reg_addr_1), .waddr(reg_addr_w), .wren(reg_w_en), .wdata(reg_wdata));
  
  sign_extension sign_extend (.immediate(imm_data), .sign_extended(extended_imm));
  
  mux operand_1_selector(.in0(), .in1(), .out(), .sel());
  
  alu arithmetics (.control(3bits), .inputA(), .inputB(), .outputALU());
  
  data_mem dataMem (.data_address(data_address), .write_data(write_data), .write_enable(write_enable), read_data(read_data));
  
  program_counter pcounter (.pc_control(pc_control), .jump_offset(jump_offset), .pc(pc), .pc_update(pc_update));
  
  // Display to Screen
  always @(posedge clk)
  begin
    $display("instruction = %b, output_data = %b, regfile_address1 = %b, regfile_address2 = %b", instruction, output_data, regfile_address1, regfile_address2);
    $monitor("instruction = %b, output_data = %b, regfile_address1 = %b, regfile_address2 = %b", instruction, output_data, regfile_address1, regfile_address2);
  end
  
  endmodule
  
  
  

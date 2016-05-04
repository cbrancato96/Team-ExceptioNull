module cpu()
 
    //Declarations
  wire [7:0] pc;
  wire [7:0] instruction;
  wire [3:0] opcode;
  wire [3:0] imm_data;
  
  // Register File I/O
  wire [1:0] reg_addr_0; // Address of Source Reg 0
  wire [1:0] reg_addr_1; // Address of Source Reg 1
  wire [1:0] reg_addr_w; // Address of Destination Reg
 
  wire [7:0] reg_data_0; // Data from Reg 0
  wire [7:0] reg_data_1; // Data from Reg 1
  wire [7:0] reg_data_w; // Data to Destination Reg
 
  // Control Unit Flags
  wire [7:0] jump; // jump = 8'b1 if opcode == (j or jal or bne or beq)
  wire sel_w_source; // sel_w_source = 1 if opcode == lw
  wire mem_w_en; // Data Memory Write Enable
  wire mem_r_en; // Data Memory Read Enable
  wire reg_w_en; // Register File Write Enable
  
  // Results
  wire [7:0] alu_result;
  wire [7:0] mem_r_result;
  
  // Assignments
  assign opcode = instruction[7:4];
  assign imm_data = instuction [3:0];
  always @(opcode)
    begin
      if (opcode == 4'b1010) begin
        assign mem_r_en = 1
 
  // Operation Instantiation
  instruction_mem instMem (.instruction_address(pc), .instruction_data(instruction));
  
  control_unit ctrl (.instruction(instruction), .jump(jump), .sel_w_source(sel_w_source), .mem_w_e    n(mem_w_en), .reg_w_en(reg_w_en));
  
  reg_file regs (.raddr0(reg_addr_0), .raddr1(reg_addr_1), .waddr(reg_addr_w), .wren(reg_w_en), .w    data(reg_wdata));
  
  alu arithmetics (.control(3bits), .inputA(), .inputB(), .outputALU());
  
  data_mem dataMem (.data_address(data_address), .write_data(write_data), .write_enable(write_enab    le), read_data(read_data));
  
  program_counter pcounter (.pc_control(jump), .jump_offset(jump_offset), .pc(pc));
 // Display to Screen
 always @(posedge clk)
 begin

    $display("instruction = %b, output_data = %b, regfile_address1 = %b, regfile_address2 = %b", instruction, output_data, regfile_address1, regfile_address2);
    $monitor("instruction = %b, output_data = %b, regfile_address1 = %b, regfile_address2 = %b", instruction, output_data, regfile_address1, regfile_address2);
  end
  
  endmodule
  
  
  

module cpu()
  
  wire [7:0] pc;
  wire [7:0] instruction;
  
  wire [1:0] reg_add_s0;
  wire [1:0] reg_add_s1;
  wire [1:0] reg_add_w;
  
  wire [7:0] reg_sdata0;
  wire [7:0] reg_sdata1;
  wire [7:0] imm_data;
  wire [7:0] reg_wdata;
  
  wire [3:0] opcode;
  wire [7:0] op1;
  wire sel_op1;
  wire sel_w_loc;
  wire sel_w_result;
  wire mem_w_en;
  wire reg_w_en;
  
  wire [7:0] alu_result;
  wire [7:0] mem_r_result;

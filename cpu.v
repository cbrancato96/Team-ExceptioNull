module cpu()
  
  wire [7:0] pc;
  wire [7:0] instruction;
  
  wire [1:0] reg_sadd0;
  wire [1:0] reg_sadd1;
  wire [1:0] reg_wadd;
  
  wire [7:0] reg_sdata0;
  wire [7:0] reg_sdata1;
  wire [7:0] reg_wdata;
  
  wire [3:0] opcode;
  wire [7:0] imm_data;
  wire sel_w_loc;
  wire mem_w_en;
  
  wire [7:0] alu_result;
  wire [7:0] mem_r_result;
  wire [7:0] 

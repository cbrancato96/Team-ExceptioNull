`include "instruction_mem.v"
`include "control_unit.v"
`include "alu.v"
`include "data_mem.v"
`include "program_counter.v"
module cpu();
 
  //Declarations
  reg [2:0] state;
  wire [2:0] state_update;
  reg [7:0] instruction;
  reg fetch;
  reg decode;
  reg execute;
  reg access_mem;
  reg update_pc;
  
  wire [7:0] instruction_data;
  wire [7:0] pc;
  wire [3:0] opcode;
  
  // Register File I/O
  reg [7:0] reg_file [3:0]; 
  
  wire [1:0] reg_addr_0; // Address of Source Reg 0
  wire [1:0] reg_addr_1; // Address of Source Reg 1
  wire [1:0] reg_addr_w; // Address of Destination Reg
 
  reg [7:0] reg_data_0; // Data from Reg 0
  reg [7:0] reg_data_1; // Data from Reg 1
  reg [7:0] reg_data_w; // Data to Destination Reg
 
  // Control Unit Flags
  wire [7:0] jump; // jump = 8'b1 if opcode == (j or jal or bne or beq)
  wire [7:0] sel_w_source; // sel_w_source = 1 if opcode == lw
  wire mem_w_en; // Data Memory Write Enable
  wire mem_r_en; // Data Memory Read Enable
  wire reg_w_en; // Register File Write Enable

  // Data Memory Interactions
  wire [7:0] mem_data_r;
  reg [7:0] mem_data_w;
  reg [7:0] mem_address;
  
  // Results
  wire [7:0] alu_result;
  wire branch;
  wire overflow;
  reg [7:0] jump_offset;
  reg [7:0] mem_r_result;
  
  // Assignments
  assign opcode = instruction [7:4];
  assign state_update = state + 1;
  
  always @(state) begin
    case (state)
      3'b000: // Fetch Instruction
        begin
          fetch <= 1'b1;
          instruction = instruction_data;
	  fetch <= 1'b0;
          state <= state_update; 
        end
      3'b001: // Decode Instruction
        begin
          decode <= 1'b1;
          decode <= 1'b0; //changed from #1 0'b0 to this
          state <= state_update;
        end
      3'b010: // Get Data From Registers
        begin
          reg_data_0 <= reg_file[reg_addr_0];
          reg_data_1 <= reg_file[reg_addr_1];
          if (opcode == 4'b1100 || opcode == 4'b1101) begin // beq or bne
            jump_offset <= reg_file[2'b00];
          end
          state <= state_update;
        end
      3'b011: // Execute
        begin
          execute <= 1'b1;
          execute <= #1 1'b0;
          state <= state_update;
        end
      3'b100: // Data Memory Access
        begin
          if (mem_r_en || mem_w_en) begin
	    if (opcode == 4'b1010 || opcode == 4'b1011)
	      mem_address <= reg_data_0;
              mem_r_result <= mem_data_r;
              mem_data_w <= reg_data_1;
            end
            access_mem <= 1'b1;
            access_mem <= #1 1'b0;
          state <= state_update;
        end
      3'b101: // Writeback Data Resolution
        begin
            reg_data_w <= (alu_result & (~sel_w_source) + mem_r_result & sel_w_source); 
          state <= state_update;
        end
      3'b110: // Writeback
        begin
          if (reg_w_en) begin
            reg_file[reg_addr_w] <= reg_data_w;
            end
          state <= state_update;  
        end
      3'b111: // PC Update
        begin
          update_pc <= 1'b0;
          update_pc <= #1 1'b1;
          state <= state_update;
        end
      endcase
    end  
 
  // Operation Instantiation
  instruction_mem instMem (.instruction_address(pc),
	                   .instruction_data(instruction_data),
		           .clk(fetch));
  
  control_unit ctrl (.instruction(instruction),
                      .mem_w_en(mem_w_en),
                      .reg_w_en(reg_w_en),
                      .sel_w_source(sel_w_source),
                      .mem_r_en(mem_r_en),
                      .reg_addr_0(reg_addr_0),
                     .reg_addr_1(reg_addr_1),
                     .reg_addr_w(reg_addr_w),
                     .clk(decode));

  alu arithmetics (.instruction(instruction),
                   .pc(pc),
                   .in0(reg_data_0),
                   .in1(reg_data_1),
                   .out(alu_result),
                   .overflow(overflow),
                   .clk(execute));
  
  data_memory dataMem (.data_address(mem_address),
                    .write_data(mem_data_w),
                    .write_enable(mem_w_en),
                    .read_data(mem_data_r),
                    .clk(access_mem));
  
  program_counter pcounter (.pc_control(jump),
                            .jump_offset(jump_offset),
                            .pc(pc),
                            .clk(update_pc));
                            
 // Display to Screen
//always @(state == 3'b0)
 initial begin
   state = 3'b1;	 
   $display("state = %b, instruction = %b, pc = %b, reg_addr_0 = %b, reg_addr_1 = %b, reg_addr_w = %b, reg_data_0 = %b, reg_data_1 = %b, reg_data_w = %b",
                     state,instruction, pc,
                     reg_addr_0, reg_addr_1, reg_addr_w,
                     reg_data_0, reg_data_1, reg_data_w);
    $monitor("state = %b, instruction = %b, pc = %b, reg_addr_0 = %b, reg_addr_1 = %b, reg_addr_w = %b, reg_data_0 = %b, reg_data_1 = %b, reg_data_w = %b",
                     state, instruction, pc,
                     reg_addr_0, reg_caddr_1, reg_addr_w,
                     reg_data_0, reg_data_1, reg_data_w);
   #10 state = 3'b0;
  end

  endmodule

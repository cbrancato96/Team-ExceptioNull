module cpu()
 
  //Declarations
  reg [2:0] state;
  reg [2:0] state_update;
  reg [7:0] instruction;
  reg update_pc;
  reg access_mem;
  reg decode;
  reg execute;
  
  wire [7:0] instruction_data;
  wire [7:0] pc;
  wire [3:0] opcode;
  
  // Register File I/O
  reg [7:0] reg_file [3:0]
  
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
  wire branch;
  wire overflow;
  wire [7:0] jump_offset;
  wire [7:0] mem_r_result;
  
  // Assignments
  assign opcode instruction [7:4];
  assign state_update = state + 1;
  assign result = (alu_result & (~sel_w_source) + mem_r_result & sel_w_source)
  
  always @(state) begin
    case (state)
      3'b000: // Fetch Instruction
        begin
          instruction <= instuction_data;
          state <= state_update; 
        end
      3'b001: // Decode Instruction
        begin
          decode <= 1'b1;
          decode <= #1 0'b0;
          state <= state_update;
        end
      3'b010: // Get Data From Registers
        begin
          assign reg_data_0 = reg_file[reg_addr_0];
          assign reg_data_1 = reg_file[reg_addr_1];
          if (opcode == 4'b1100 || opcode == 4'b1101) begin // beq or bne
            assign jump_offset = reg_file[2'b00];
          end
          state <= state_update;
        end
      3'b011: // ALU
        begin
          execute <= 1'b1;
          execute <= #1 1'b0;
          state <= state_update;
        end
      3'b100: // Data Memory Access
        begin
          if (mem_r_en || mem_w_en) begin
            access_mem <= 1'b1;
            access_mem <= #1 1'b0;
            end
          state <= state_update;
        end
      3'b101: // Writeback Data Resolution
        begin
            reg_w_data <= (alu_result & (~sel_w_source) + mem_r_result & sel_w_source)
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
  instruction_mem instMem (.instruction_address(pc), .instruction_data(instruction_data));
  
  control_unit ctrl (.instruction(instruction)
                     .jump(jump),
                     .sel_w_source(sel_w_source),
                     .mem_w_en(mem_w_en),
                     .reg_w_en(reg_w_en),
                     .mem_r_en(mem_r_en),
                     .reg_addr_0(reg_addr_0),
                     .reg_addr_1(reg_addr_1),
                     .reg_addr_w(reg_addr_w));
  
  alu arithmetics (.instruction(instruction)
                   .in0(reg_data_0),
                   .in1(reg_data_1)
                   .out(alu_result)
                   .overflow(overflow));
  
  data_mem dataMem (.data_address(data_address),
                    .write_data(write_data),
                    .write_enable(write_enable),
                    .read_data(read_data),
                    .clk(access_mem));
  
  program_counter pcounter (.pc_control(jump),
                            .jump_offset(jump_offset),
                            .pc(pc)
                            .clk(update_pc));
                            
 // Display to Screen
 always @(posedge clk)
 begin

    $display("instruction = %b, output_data = %b, regfile_address1 = %b, regfile_address2 = %b", instruction, output_data, regfile_address1, regfile_address2);
    $monitor("instruction = %b, output_data = %b, regfile_address1 = %b, regfile_address2 = %b", instruction, output_data, regfile_address1, regfile_address2);
  end
  
  endmodule
  
  
  

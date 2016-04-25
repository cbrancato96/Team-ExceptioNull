module control_unit(
  inst op,
  data_mem_wren,
  reg_file_wren,
  reg_file_dmux_select,
  reg_file_rmux_select,
  alu_mux_select,
  alu_control,
  alu_zero,
  pc_control);


  input [7:4] op;
  input alu_zero;
  
  output 
  
  
  wire [3:0]
  assign instruction = op [0:3]
  always @(op)
  begin
    if op = 0000    //Move
      alu control = 011;
      branch = 0;
      alu_src = 1;
      wren_reg = 1;
      wren_data = 0;
      datamem_toreg = 1;
      end 
      
    else
    if op = 0001    //Add
      alu control = 011;
      branch = 0;
      alu_src = 1;
      wren_reg = 1;
      wren_data = 0;
      datamem_toreg = 1;
      end
      
    else 
    if op = 0010    //And
      alu control = 011;
      branch = 0;
      alu_src = 1;
      wren_reg = 1;
      wren_data = 0;
      datamem_toreg = 1;
      end
      
    else 
    if op = 0011    //Not
      alu control = 011;
      branch = 0;
      alu_src = 1;
      wren_reg = 1;
      wren_data = 0;
      datamem_toreg = 1;
      end
      
    else 
    if op = 0100    //Nor
      alu control = 011;
      branch = 0;
      alu_src = 1;
      wren_reg = 1;
      wren_data = 0;
      datamem_toreg = 1;
      end
      
    else 
    if op = 0101    //Slt: Set Less Than 
      alu control = 101;
      branch = 0;
      alu_src = 1;
      wren_reg = 1;
      wren_data = 0;
      datamem_toreg = 1;
      end
      
    else
    if op = 0110    //Sll: Shift Left Logical
      alu control = 110;
      branch = 0;
      alu_src = 1;
      wren_reg = 0;
      wren_data = 0;
      datamem_toreg = 1;
      end
      
    else 
    if op = 0111    //Srl: Shift Right Logical
      alu control = 111;
      branch = 0;
      alu_src = 1;
      wren_reg = 0;
      wren_data = 0;
      datamem_toreg = 1;
      end
      
    else 
    if op = 1000    //J: Jump
      alu control = 000;
      branch = 1;
      alu_src = 1;
      wren_reg = 0;
      wren_data = x;
      datamem_toreg = x;
      end
      
    else 
    if op = 1001    //Jal: Jump and link
      alu control = 001;
      branch = 1;
      alu_src = 1;
      wren_reg = 0;
      wren_data = x;
      datamem_toreg = x;
      end
      
   else 
    if op = 1010    //lw: load word
      alu control = 010;
      branch = 0;
      alu_src = 1;
      wren_reg = 0;
      wren_data = 0;
      datamem_toreg = 1;
      end
      
   else 
    if op = 1011    //sw: store word
      alu control = 011;
      branch = 0;
      alu_src = x;
      wren_reg = 1;
      wren_data = 1;
      datamem_toreg = 1;
      end
      
   else 
    if op = 1100   //beq: branch if equal
      alu control = 100;
      branch = 1;
      alu_src = 1;
      wren_reg = 0;
      wren_data = 0;
      datamem_toreg = 0;
      end
      
   else 
    if op = 1101   //bne: branch not equal
      alu control = 101;
      branch = 1;
      alu_src = 1;
      wren_reg = 0;
      wren_data = 0;
      datamem_toreg = x;
      end
      
   else 
    if op = 1110   //addi: add immediate
      alu control = 110;
      branch = 0;
      alu_src = 1;
      wren_reg = 0;
      wren_data = 0;
      datamem_toreg = 0;
   
   else 
    if op = 1111   //li: load immediate
      alu control = 111;
      branch = 0;
      alu_src = 1;
      wren_reg = 1;
      wren_data = 0;
      datamem_toreg = 1;
      end
      
      
endmodule

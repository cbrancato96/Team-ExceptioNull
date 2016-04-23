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


input [0:7] instruction;
input alu_zero;

output 


wire [3:0]
assign instruction = op [0:3]
always @(op)
begin
	if op = 0000    //Move
		begin
			alu control = 011;
			branch = 0;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 1;
			wren_data = 0;
			datamem_toreg = 1;
		end
	else if op = 0001    //Add
		begin
			alu control = 011;
			branch = 0;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 1;
			wren_data = 0;
			datamem_toreg = 1;
		end
	else if op = 0010    //And
		begin
			alu control = 011;
			branch = 0;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 1;
			wren_data = 0;
			datamem_toreg = 1;
		end
	else if op = 0011    //Not
		begin
			alu control = 011;
			branch = 0;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 1;
			wren_data = 0;
			datamem_toreg = 1;
		end
	else if op = 0100    //Nor
		begin
			alu control = 011;
			branch = 0;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 1;
			wren_data = 0;
			datamem_toreg = 1;
		end
	else if op = 0101    //Slt: Set Less Than
		begin 
			alu control = 101;
			branch = 0;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 1;
			wren_data = 0;
			datamem_toreg = 1;
		end
	else if op = 0110    //Sll: Shift Left Logical
		begin	
			alu control = 110;
			branch = 0;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 0;
			wren_data = 0;
			datamem_toreg = 1;
		end
	else if op = 0111    //Srl: Shift Right Logical
		begin
			alu control = 111;
			branch = 0;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 0;
			wren_data = 0;
			datamem_toreg = 1;
		end
	else if op = 1000    //J: Jump
		begin
			alu control = 000;
			branch = 1;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 0;
			wren_data = x;
			datamem_toreg = x;
		end
	else if op = 1001    //Jal: Jump and link
		begin
			alu control = 001;
			branch = 1;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 0;
			wren_data = x;
			datamem_toreg = x;
		end
	else if op = 1010    //lw: load word
		begin
			alu control = 010;
			branch = 0;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 0;
			wren_data = 0;
			datamem_toreg = 1;
		end
	else if op = 1011    //sw: store word
		begin
			alu control = 011;
			branch = 0;
			reg_dest = ;
			alu_src = x;
			wren_reg = 1;
			wren_data = 1;
			datamem_toreg = 1;
		end 
	else if op = 1100   //beq: branch if equal
		begin
			alu control = 100;
			branch = 1;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 0;
			wren_data = 0;
			datamem_toreg = 0;
		end
	else if op = 1101   //bne: branch not equal
		begin
			alu control = 101;
			branch = 1;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 0;
			wren_data = 0;
			datamem_toreg = x;
		end
	else if op = 1110   //addi: add immediate
		begin
			alu control = 110;
			branch = 0;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 0;
			wren_data = 0;
			datamem_toreg = 0;	
		end
	else if op = 1111   //li: load immediate
		begin
			alu control = 111;
			branch = 0;
			reg_dest = ;
			alu_src = 1;
			wren_reg = 1;
			wren_data = 0;
			datamem_toreg = 1;	
		end
end
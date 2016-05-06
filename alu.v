module alu(
instruction,	//specifies the alu operation
pc,
in0, 		//first input
in1, 		//second input
out, 		//alu output
jump,
overflow);

input [7:0] instruction;
input [7:0] in0; 
input [7:0] in1;
input [7:0] pc;
	
output [7:0] out;
output [7:0] jump;
output overflow;

reg [7:0] out;
reg [7:0] jump;
reg overflow;
wire [3:0] opcode;
wire [1:0] imm2;
wire [3:0] imm4;


assign opcode = instruction[7:4];
assign imm2 = instruction [1:0];
assign imm4 = instruction [3:0];

always @(opcode) begin
  case (opcode)
    4'b0000 : // Move
    begin
    out = in0;
    overflow = 0;
    jump = 8'b0;
    end	
    
    4'b0001: // Signed ADD
    begin
    jump = 8'b0;
    out = $signed(in0) + $signed(in1);
      if ((in0 >= 0 && in1 >= 0 && out < 0) || (in0 < 0 && in1 < 0 && out >= 0)) 
	begin
	  overflow = 1;
	end else 
	begin
          overflow = 0;
	end
    end	
		
		4'b0010: // AND
		begin
		out = in0 & in1;
		overflow = 0;
    jump = 8'b0;
		end
			
		4'b0011: // NOT
		begin
		out = ~in0;
		overflow = 0;
    jump = 8'b0;
    end
		
		4'b0100: // NOR
		begin
		out = ~(in0 | in1);
		overflow = 0; 
    jump = 8'b0;
    end
    
    4'b0101: //Set Less Than
    begin
    jump = 8'b0;
    if ($signed(in0) > $signed(in1))
       out = 8'b1;
    else 
       out = 8'b0;
    end
    
    4'b0110: // Shift Left Logical
    begin
    out = in1 << imm2;
    overflow=0;
    jump = 8'b0;
    end
			
    4'b0111: // Shift Right Logical
    begin
    out = in1 >> imm2;
    overflow=0;
    jump = 8'b0;
    end
    
    4'b1000: // Jump
    begin
    out = in1 - pc - 1;
    jump = 8'b11111111;
    end
    
    4'b1001: // Jump and Link
    begin
    out = in1 - pc - 1;
    jump = 8'b11111111;
    end
    
    4'b1010: // Load Word
    begin
    jump = 8'b0;
    end
    
    4'b1011: // Store Word
    begin
    jump = 8'b0;
    end
    
    4'b1100: // Branch On Equal
    begin
    if (in1 == in0) begin
    	jump = 8'b11111111;
    end else
      jump = 8'b0;
   	end
		
    4'b1101: // Branch On Not Equal
    begin
    if (in1 != in0) begin
    	jump = 8'b11111111;
    end else
      jump = 8'b0;
   	end
    
    4'b1110: // Add Immediate
    begin
    out = $signed(imm2) + $signed(in1);
    jump = 0;
    end
    
    4'b1111: // Load Immediate
    begin
    out = $signed(imm2);
    jump = 8'b0;
    end
		
		default:
		begin
  	overflow = 0;
		end				
		
		endcase
		
	end

 endmodule
 /*
 // Testbench
 module test();
  reg [7:0] instruction;
  reg [7:0] in0;
  reg [7:0] in1;
  reg [7:0] pc;
  wire [7:0] out;
  wire [7:0] jump;
  wire overflow;
  
  alu ALU(
    .instruction(instruction),
    .in0(in0),
    .pc(pc),
    .in1(in1),
    .out(out),
    .jump(jump),
    .overflow(overflow));
 
  initial begin
    	instruction = 8'b0;
    	in0 = 8'b11111111;
    	in1 = 8'b111;
	pc = 8'b11;
    $monitor("instruction=%b, in0=%b, in1=%b, out=%b, jump=%b overflow=%b", instruction, in0, in1, out, jump, overflow);
 	#10 instruction = 8'b00011101;
    #10 instruction = 8'b00101101;
    #10 instruction = 8'b00111101;
    #10 instruction = 8'b01001101;
    #10 instruction = 8'b01011101;
    #10 instruction = 8'b01101101;  
    #10 instruction = 8'b01111101;
    #10 instruction = 8'b10001101;
    #10 instruction = 8'b10011101;
    #10 instruction = 8'b10101101;
    #10 instruction = 8'b10111101;
    #10 instruction = 8'b11001101;
    #10 instruction = 8'b11011101;
    #10 instruction = 8'b11101101;
    #10 instruction = 8'b11111101;
    #10 instruction = 8'b11101011;
    #10 instruction = 8'b11111011;
    #10 in0 = 8'b100;
    #10 instruction = 8'b01011011;
  end
endmodule
*/
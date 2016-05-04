module alu(
    instruction,	//specifies the alu operation
    in0, 		//first input
    in1, 		//second input
    out, 		//alu output
    overflow);

input [7:0] instruction;
input [7:0] in0; 
input [7:0] in1;
	
output [7:0] out; 
output overflow;

reg [7:0] out;
reg overflow;
wire [3:0] opcode;

assign opcode = instruction[7:4];

always @(opcode) begin

  case (opcode)
    3'b0000 : // Move
    begin
    out = in0;
    overflow = 0; 
    end	
    
    3'b0001: // Signed ADD
    begin
    out = input0 + input1;
    if ((in0 >= 0 && in1 >= 0 && out < 0) || (in0 < 0 && in1 < 0 && out >= 0)) 
			begin
							overflow = 1;
						end 
					else 
						begin
							overflow = 0;
						end
		end	
		
		3'b010: // AND
		begin
		out = in0 & in1;
		overflow = 0; 
		end
			
		3'b011: // NOT
		begin
		out = ~in0;
		overflow = 0;
    end
		
		3'b100: // NOR
		begin
		out = ~(in0 | in1);
		overflow = 0; 
    end
    
		3'b110: // Shift Left Logical
		begin
		out = in0 << 1;
		overflow=0;
    end
			
		3'b111: // Shift Right Logical
		begin
		out = in0 >> 1;
		overflow=0;
    end
		
		default:
		begin
		overflow=0;
		end				
		
		endcase
		
	end


 endmodule

//Testbench

module test();
  reg [7:0] instruction;
  reg [7:0] in0;
  reg [7:0] in1;
  wire [7:0] out;
  wire overflow;
  
  alu ALU(
    .instruction(instruction),
    .in0(in0),
    .in1(in1),
    .out(out),
    .overflow(overflow));
 
  initial begin
    $display("instruction=%b, in0=%b, in1=%b, out=%b, overflow=%b, instruction, in0, in1, out, overflow);
    	instruction = 8'b0;
    	in0 = 8'b01;
    	in1 = 8'b11;
    $monitor("instruction=%b, in0=%b, in1=%b, out=%b, overflow=%b, instruction, in0, in1, out, overflow);
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

    	
  end

endmodule

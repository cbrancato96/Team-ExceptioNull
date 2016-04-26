// Code your design here

//-----------------------------------------------------------------------
// Engineers	: 	Krishna Thiyagarjan, Chirs Brancato, Ihsan Gunay
// College		:	The Cooper Union for the Advancement of Science & Art
// Create Date	:	04/23/2016
// Design Name	:	Arithmetic Logic Unit
// Module Name	: 	alu.v
// Project Name	: 	8-Bit MIPS Processor
// Purpose:		Describes an ALU
//-----------------------------------------------------------------------

module alu(
    control,	//specifies the alu operation
    input0, 	//first input
    input1, 	//second input
    alu_output, 	//alu output
    zero, 		//zero flag
	overflow);

    //--------------------------
	// Inputs
	//--------------------------

    input 		[2:0]	control;
	input 		[7:0] 	input0; 
	input		[7:0]	input1;
	
    //--------------------------
    // Outputs
    //--------------------------

	output 	[7:0] 	alu_output; 
	output			overflow;
	output			zero;
	
    //--------------------------
    // Begin Design
    //--------------------------
    
    //--------------------------
    // Register Declarations: 
    //-------------------------- 
	reg [7:0]		alu_output;
	reg 		overflow;
	reg 		zero;
	
    //--------------------------
    // Combinational Logic
    //--------------------------

	always @(control)
	begin
	
		case (control)
			3'b000 : // Move
				begin
					alu_output = input0;
                  zero = (alu_output == 0) ? 1 : 0;
				end	
			3'b001: // ADD
				begin
					alu_output = input0 + input1;
                  zero = (alu_output == 0) ? 1 : 0;
				end	
			3'b010: // AND
				begin
					alu_output = input0 & input1;
                  zero = (alu_output == 0) ? 1 : 0;
				end
			3'b011: // NOT
				begin
					alu_output = ~input0;
                  zero = (alu_output == 0) ? 1 : 0;
				end
			3'b100: // NOR
				begin
					alu_output = ~(input0 | input1);
                  zero = (alu_output == 0) ? 1 : 0;
				end
			3'b110: // Shift Left Logical
				begin
					alu_output = input0 << 1;
                  zero = (alu_output == 0) ? 1 : 0;
				end
			3'b111: // Shift Right Logical
				begin
					alu_output = input0 >> 1;
                  zero = (alu_output == 0) ? 1 : 0;
				end
			default:
				begin
					zero = 0;
				end				
		endcase
		
	end


 endmodule
 
 // Code your testbench here
// or browse Examples
module test();
  reg [2:0] control;
  reg [7:0] input0;
  reg [7:0] input1;
  wire [7:0] alu_output;
  wire overflow;
  wire zero; 
  
  alu ALU(
    .control(control),
    .input0(input0),
    .input1(input1),
    .alu_output(alu_output),
    .overflow(overflow),
    .zero(zero));
 
  initial begin
    $display("control=%b, input0=%b, input1=%b, alu_output=%b, overflow=%b, zero=%b", control, input0, input1, alu_output, overflow, zero);
    control = 3'b000;
    input0 = 8'b01;
    input1 = 8'b11111111;
    $monitor("control=%b, input0=%b, input1=%b, alu_output=%b, overflow=%b, zero=%b", control, input0, input1, alu_output, overflow, zero);
  end

endmodule

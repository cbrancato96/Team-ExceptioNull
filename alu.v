`timescale 1ns / 1ps
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
    output, 	//alu output
    zero 		//zero flag
);

    //--------------------------
	// Inputs
	//--------------------------

    input 		[2:0]	control;
	input 		[7:0] 	input0; 
	input		[7:0]	input1;
	
    //--------------------------
    // Outputs
    //--------------------------

    output 	[7:0] 	output; 
	output			overflow;
	output			zero;
	
    //--------------------------
    // Begin Design
    //--------------------------
    
    //--------------------------
    // Register Declarations: 
    //-------------------------- 
    reg [7:0]	output;
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
					output = input0;
					zero = (output == 0) ? 1 : 0;
				end	
			3'b001: // ADD
				begin
					output = input0 + input1;
					zero = (output == 0) ? 1 : 0;
				end	
			3'b010: // AND
				begin
					output = input0 & input1;
					zero = (output == 0) ? 1 : 0;
				end
			3'b011: // NOT
				begin
					output = ~input0;
					zero = (output == 0) ? 1 : 0;
				end
			3'b100: // NOR
				begin
					output = ~(input0 | input1);
					zero = (output == 0) ? 1 : 0;
				end
			3'b110: // Shift Left Logical
				begin
					output = input0 << 1;
					zero = (output == 0) ? 1 : 0;
				end
			3'b111: // Shift Right Logical
				begin
					output = input0 >> 1;
					zero = (output == 0) ? 1 : 0;
				end
			default:
				begin
					zero = 0;
				end				
		endcase
		
	end


 endmodule
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
    inputA, 	//first input
    inputB, 	//second input
    outputALU, 	//alu output
    zero, 		//zero flag
    overflow);

input 		[2:0]	control;
input 		[7:0] 	inputA; 
input		[7:0]	inputB;
	
output 	[7:0] 	outputALU; 
output			overflow;
output			zero;
	
    //--------------------------
    // Begin Design
    //--------------------------
    
    //--------------------------
    // Register Declarations: 
    //-------------------------- 
	reg [7:0]		outputALU;
	reg 			overflow;
	reg 			zero;
	
    //--------------------------
    // Combinational Logic
    //--------------------------

	always @(control)
	begin
	
		case (control)
			3'b000 : // Move
				begin
					outputALU = inputA;
					overflow = 0; 
                  	zero = (outputALU == 0) ? 1 : 0;
				end	
			3'b001: // Signed ADD
				begin
					outputALU = inputA + inputB;
					
					if ((inputA >= 0 && inputB >= 0 && outputALU < 0) || (inputA < 0 && inputB < 0 && outputALU >= 0)) 
						begin
							overflow = 1;
						end 
					else 
						begin
							overflow = 0;
						end
					zero = (outputALU == 0) ? 1 : 0;
				end	
			3'b010: // AND
				begin
					outputALU = inputA & inputB;
					overflow = 0; 
                  	zero = (outputALU == 0) ? 1 : 0;
				end
			3'b011: // NOT
				begin
					outputALU = ~inputA;
					overflow = 0;
                  	zero = (outputALU == 0) ? 1 : 0;
				end
			3'b100: // NOR
				begin
					outputALU = ~(inputA | inputB);
					overflow = 0; 
                  	zero = (outputALU == 0) ? 1 : 0;
				end
			3'b110: // Shift Left Logical
				begin
					outputALU = inputA << 1;
					overflow=0;
                  	zero = (outputALU == 0) ? 1 : 0;
				end
			3'b111: // Shift Right Logical
				begin
					outputALU = inputA >> 1;
					overflow=0;
                  	zero = (outputALU == 0) ? 1 : 0;
				end
			default:
				begin
					zero = 0;
					overflow=0;
				end				
		endcase
		
	end


 endmodule

//Testbench

module test();
  reg [2:0] control;
  reg [7:0] inputA;
  reg [7:0] inputB;
  wire [7:0] outputALU;
  wire overflow;
  wire zero; 
  
  alu ALU(
    .control(control),
    .inputA(inputA),
    .inputB(inputB),
    .outputALU(outputALU),
    .overflow(overflow),
    .zero(zero));
 
  initial begin
    $display("control=%b, inputA=%b, inputB=%b, outputALU=%b, overflow=%b, zero=%b", control, inputA, inputB, outputALU, overflow, zero);
    	control = 3'b000;
    	inputA = 8'b01;
    	inputB = 8'b11111111;
    $monitor("control=%b, inputA=%b, inputB=%b, outputALU=%b, overflow=%b, zero=%b", control, inputA, inputB, outputALU, overflow, zero);
  end

endmodule

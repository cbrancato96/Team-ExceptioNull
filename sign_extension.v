module sign_extension (immediate, sign_extended, clk);
  
  input clk;
  input [1:0] immediate;
  output [7:0] sign_extended;
  
  reg [7:0] sign_extended;
  
  always @(posedge clk) 
    begin
      sign_extended[7:0] <= $signed(immediate);
	end
endmodule
/*
//Testbench
module test();
  reg clk;
  reg [1:0] immediate;
  wire [7:0] sign_extended;
  
  sign_extension SIGN_EXTENSION(
    .clk(clk),
    .immediate(immediate),
    .sign_extended(sign_extended));
  
  initial begin
    $display("Initial conditions");
    clk = 0;
   	immediate = 10;
    
    clk = 1;
    display;
  end
  
 task display;
   #1 $display("immediate=%b, sign_extended=%b, clk=%b", immediate, sign_extended, clk);
 endtask
  
endmodule
*/
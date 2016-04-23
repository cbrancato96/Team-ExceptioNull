module mux(
  in0,
  in1,
  out,
  sel);
  
  input [7:0] in0;
  input [7:0] in1;
  input sel;
  
  output [7:0] out;
  
  assign out = (sel == 0) ? in0 : in1;

endmodule

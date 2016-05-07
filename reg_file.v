module reg_file(
  raddr0,
  raddr1,
  waddr,
  wdata,
  wren,
  rdata0,
  rdata1);

  input [1:0] raddr0;
  input [1:0] raddr1;
  input [1:0] waddr;
  input [7:0] wdata;
  input wren;
  
  output [7:0] rdata0;
  output [7:0] rdata1;

  reg [7:0] reg_file [7:0];
  
  assign rdata0 = reg_file[raddr0];
  assign rdata1 = reg_file[raddr1];
  
  integer i;
  
  initial
  begin                     //initializing the regfile bits to 0
    for (i=0; i<8; i=i+1)
      begin
        reg_file[i] = 0;
      end
  end

  always @(wren)                  
  begin
    if (wren == 1) begin
    reg_file[waddr] <= wdata;
  end
  end
endmodule

/*
// Testbench
module test();
  reg [1:0] raddr0;
  reg [1:0] raddr1;
  reg [1:0] waddr;
  reg [7:0] wdata;
  reg wren;
  wire [7:0] rdata0;
  wire [7:0] rdata1;  
  
  reg_file REG_FILE(
    .raddr0(raddr0),
    .raddr1(raddr1),
    .waddr(waddr),
    .wdata(wdata),
    .wren(wren),
    .rdata0(rdata0),
    .rdata1(rdata1));
 
  initial begin
    $display("rdata0=%b, rdata1=%b", rdata0, rdata1);
    raddr0 = 2'b0;
    raddr1 = 2'b11;
    wren = 1;
    waddr = 2'b00;
    wdata = 8'b10101010;
    $monitor ("raddr0=%b,raddr1=%b, rdata0=%b,	rdata1=%b", raddr0, raddr1, rdata0, rdata1);
  end

endmodule

)*/
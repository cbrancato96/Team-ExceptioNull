module data_memory (
  data_address,
  write_data,
  write_enable,
  read_data,
  clk
);

input [7:0] data_address; //data RAM depth is 64 lines
input [7:0] write_data; 
input write_enable;
input clk;
  
output [7:0] read_data;

reg [7:0] data_mem [64:127];
reg [7:0] read_data;
parameter DATA = "dataMem.bin";

  always @ (posedge clk) 
    begin
          if (write_enable == 1) begin     
    			data_mem[data_address] <= write_data;
		end else
          begin
			read_data <= data_mem[data_address];
        end
    end
    
initial begin
  $readmemb(DATA, data_mem);
end
  
endmodule
/*
// Testbench
module test();

  reg [7:0] data_address;
  reg [7:0] write_data;
  reg write_enable;
  reg clk;
  wire [7:0] read_data;
  
  data_memory DATA_MEMORY(
    .data_address(data_address),
    .write_data(write_data),
    .write_enable(write_enable),
    .clk(clk),
    .read_data(read_data));
 
  initial begin
    $display("data_address=%b, write_data=%b, write_enable=%b, read_data=%b", data_address, write_data, write_enable, read_data);
    clk = 0;
	write_enable = 1'b0;
    data_address = 8'b1000010;
	write_data = 8'b1;
    $monitor("data_address=%b, write_data=%b, write_enable=%b, read_data=%b, clk=%b", data_address, write_data, write_enable, read_data, clk);
    write_enable = 1'b1;
    #10 clk = 1;
    write_enable = 1'b1;
    #10 clk = 0;

    #10 clk = 1;
    write_enable = 1'b0;

    #10 clk = 0; 
  end

endmodule
*/
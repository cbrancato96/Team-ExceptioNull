// Code your design here
module data_mem (
data_address,
write_data,
write_enable,
read_data);

input [5:0] data_address; //data RAM depth is 64 lines
input [7:0] write_data; 
input write_enable;
  
output [7:0] read_data;

assign read_data = mem[data_address];
reg [7:0] mem [4:0];
wire [7:0] read_data;
  
	always @(write_enable)
		begin
          if (write_enable == 1) begin     
    		mem[data_address] <= write_data;
		  end
        end
endmodule

// Code your design here
module  memory();
  reg [7:0] data_memory [0:5];

initial begin
  $readmemh("datamemory.list", data_memory);
end
endmodule

module test();
  reg [5:0] data_address;
  reg [7:0] write_data;
  reg write_enable;
  wire [7:0] read_data;
  
  data_mem data_mem(
    .data_address(data_address),
    .write_data(write_data),
    .write_enable(write_enable),
    .read_data(read_data));
 
  initial begin
    $display("data_address=%b, write_data=%b, write_enable=%b, read_data=%b", data_address, write_data, write_enable, read_data);
	write_enable = 0;
    data_address = 0;
    write_data = 1;
    $monitor("data_address=%b, write_data=%b, write_enable=%b, read_data=%b", data_address, write_data, write_enable, read_data);
  end

endmodule

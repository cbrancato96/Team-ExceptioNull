module data_mem () ;

input [5:0] data_address; //data RAM depth is 64 lines
input [7:0] write_data; 
input write_enable;
ouput [7:0] read_data;

reg [5:0] data_address;
reg [7:0] write_data;
reg [7:0] mem[4:0];

always @ (write_enable) begin
  if (write_enable)
    mem[data_address] <= write_data;
    read_data <= write_data;
  else begin
    read_data <= mem[data_address];
end

endmodule


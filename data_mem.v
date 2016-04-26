// Code your design here
module data_mem () ;

input [5:0] data_address; //data RAM depth is 64 lines
input [7:0] write_data; 
input write_enable;
output [7:0] read_data;

reg [5:0] data_address;
reg [7:0] write_data;
reg [7:0] mem [4:0];
wire [7:0] read_data;
  
always @ (write_enable) begin
 	 if (write_enable)
    mem[data_address] <= write_data;
    read_data <= write_data;
	end
else 
    
begin
    read_data <= mem[data_address];
end
  end 
endmodule

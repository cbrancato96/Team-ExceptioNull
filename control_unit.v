// Code your design here
module control_unit(
    instruction,
   // jump,
    mem_w_en,
    reg_w_en,
    sel_w_source,
    mem_r_en,
    reg_addr_0,
    reg_addr_1,
    reg_addr_w,
    clk,
  );

  input [7:0] instruction;
  input clk;
 
  //output [7:0] jump;
  output mem_w_en;
  output mem_r_en;
  output reg_w_en;
  output [7:0] sel_w_source;
  
  output [1:0] reg_addr_0;
  output [1:0] reg_addr_1;
  output [1:0] reg_addr_w;
  
  wire [3:0] opcode;
  wire [7:0] instruction;
  
  //reg [7:0] jump;
  reg mem_w_en;
  reg reg_w_en;
  reg mem_r_en;
  reg [7:0] sel_w_source;
  reg [1:0] reg_addr_0;
  reg [1:0] reg_addr_1;
  reg [1:0] reg_addr_w;

  assign opcode = instruction[7:4];
  
  always @(posedge clk)
  begin
   
    if (opcode == 4'b0000) begin   //Move
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = instruction[3:2]; 
     // jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 8'b0;
      mem_r_en = 0;
      end else
        
    if (opcode == 4'b0001) begin   //Add
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = 2'b0; 
      //jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 8'b0;
      mem_r_en = 0;
      end else 
        
    if (opcode == 4'b0010) begin   //And
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = 2'b0; 
      //jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 8'b0;
      mem_r_en = 0;
      end else
        
    if (opcode == 4'b0011) begin//Not
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = instruction[3:2]; 
     // jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 8'b0;
      mem_r_en = 0;
      end else
        
    if (opcode == 4'b0100) begin   //Nor
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = 2'b0; 
     // jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 8'b0;
      mem_r_en = 0;
  	  end else 
        
    if (opcode == 4'b0101) begin   //Slt: Set Less Than
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = 2'b0; 
    //  jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 8'b0;
      mem_r_en = 0;
      end else
        
    if (opcode == 4'b0110) begin    //Sll: Shift Left Logical
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = instruction[3:2]; 
    //  jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 8'b0;
      mem_r_en = 0;
      end else
        
    if (opcode == 4'b0111) begin   //Srl: Shift Right Logical
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2]; 
      reg_addr_w = instruction[3:2]; 
    //  jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 8'b0;
      mem_r_en = 0;
      end else 
    
    if (opcode == 4'b1000) begin   //J: Jump
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = instruction[3:2]; 
    //  jump = 8'b11111111;
      mem_w_en = 0;
      reg_w_en = 0;
      sel_w_source = 8'b0;
      mem_r_en = 0;
  	  end else 
        
    if (opcode == 4'b1001) begin    //Jal: Jump and link
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = instruction[3:2];
    //  jump = 8'b11111111;
      mem_w_en = 1;
      reg_w_en = 0;
      sel_w_source = 8'b0;
      mem_r_en = 0;
  	  end else
        
    if (opcode == 4'b1010) begin   //lw: load word
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = instruction[3:2];
    //  jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 8'b11111111;
      mem_r_en = 1;
      end else 
        
    if (opcode == 4'b1011) begin  //sw: store word
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = instruction[3:2];
    //  jump = 8'b0;
      mem_w_en = 1;
      reg_w_en = 0;
      sel_w_source = 8'b0;
      mem_r_en = 0;
      end else
        
    if (opcode == 4'b1100) begin   //beq: branch if equal
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = 2'b0;
    //  jump = 8'b11111111;
      mem_w_en = 0;
      reg_w_en = 0;
      sel_w_source = 8'b0;
      mem_r_en = 0;
      end else
        
    if (opcode == 4'b1101) begin   //bne: branch not equal
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = 2'b0;
    //  jump = 8'b11111111;
      mem_w_en = 0;
      reg_w_en = 0;
      sel_w_source = 8'b0;
      mem_r_en = 0;
      end else
        
    if (opcode == 4'b1110) begin  //addi: add immediate
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = instruction[3:2];
    //  jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 8'b0;
      mem_r_en = 0;
  	  end else 
        
    if (opcode == 4'b1111) begin //li: load immediate
      reg_addr_0 = instruction[1:0]; 
      reg_addr_1 = instruction[3:2];
      reg_addr_w = instruction[3:2];
    //  jump = 8'b0;
      mem_w_en = 0;
      reg_w_en = 1;
      sel_w_source = 8'b0;
      mem_r_en = 0;
      end
    end  
    
endmodule
/*
module test();

  reg [7:0]instruction;
  //reg [7:0]jump;
  reg mem_w_en;
  reg reg_w_en;
  reg [7:0] sel_w_source;
  reg mem_r_en;
  reg [1:0] reg_addr_0;
  reg [1:0] reg_addr_1;
  reg [1:0] reg_addr_w;
  reg clk;
  
  wire [3:0] opcode;
  
  control_unit CONTROL_UNIT(
    .instruction(instruction),
    //.jump(jump),
    .mem_w_en(mem_w_en),
    .reg_w_en(reg_w_en),
    .sel_w_source(sel_w_source),
    .mem_r_en(mem_r_en),
    .reg_addr_0(reg_addr_0),
    .reg_addr_1(reg_addr_1),
    .reg_addr_w(reg_addr_w),
    .clk(clk));
 
  initial begin
    instruction = 8'b0;
    #10ns;
    $monitor ("instruction=%b, mem_w_en=%b,	reg_w_en=%b,	sel_w_source=%b, mem_r_en=%b,	reg_addr_0=%b, reg_addr_1=%b, reg_addr_w=%b, clk=%b",instruction,mem_w_en,reg_w_en,sel_w_source, mem_r_en,reg_addr_0,reg_addr_1,reg_addr_w,clk);
    clk=0;
    #10 instruction = 8'b0;
    clk=1;
    #10 instruction = 8'b00101101;
    clk=0;
    #10 instruction = 8'b00101101;
    clk=1;

  


  end

endmodule
*/

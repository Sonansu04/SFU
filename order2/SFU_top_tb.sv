`include "SFU_top.sv"


`define RCP 	4'b0000
`define SQRT 	4'b0001
`define RSQRT 	4'b0010
`define POW2	4'b0011
`define LOG2	4'b0100
`define SIN		4'b0101
`define FMA		4'b0110
`define TANH	4'b0111

module tb;

logic precision;
logic [3:0]  opcode;	
logic [31:0] single_x;
logic [31:0] single_y;
logic [31:0] single_z;
logic [31:0] single_result;





SFU_top  s1(precision,opcode,single_x,single_y,single_z,single_result);


initial begin
	precision=1'b0;
    opcode=`SIGMOID;
	single_x=32'h0000c8fc;
	single_y=32'h39a3b295;
	single_z=32'hbf33c05d;
			
	#1
	$display("precision=%b",precision);
	$display("opcode=%b",opcode);
	$display("single_x=%h",single_x);
	$display("single_y=%h",single_y);
	$display("single_z=%h\n",single_z);
	
	$display("single_result=%b",single_result);
	

end
endmodule

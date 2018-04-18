`include "post_processor.sv"

module tb;
logic precision;
logic [3:0] opcode;
logic sign;
logic [7:0] exponent;
logic signed [3:-46] approximate_result;
logic [31:0] single_y;
logic [31:0] single_x;

logic skip;



post_processor pp(precision,opcode,sign,exponent,approximate_result,single_y,skip,single_x);

initial begin
	
	precision=1'b0;
	single_x=32'b00000000000000000101001110110111;
	skip=1;
	approximate_result=50'b0;
    opcode=`RELU6;
	sign=1'b0;
	exponent=8'b00000101;
	
	#1
	$display("precision=%b",precision);
	$display("skip=%b",skip);
	$display("opcode=%b",opcode);
	$display("exponent=%b",exponent);
	$display("single_x=%b",single_x);
	$display("single_y=%b\n",single_y);
	
	$display("test=%b\n",sign);


	


	

end
endmodule
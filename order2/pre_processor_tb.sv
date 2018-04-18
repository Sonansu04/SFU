`include "pre_processor.sv"




module tb;
logic [3:0] opcode;
logic [31:0] single_x;
logic [31:0] single_y;
logic [31:0] single_z;
logic precision;

logic sign;
logic signed [7:0] exponent;

logic signed [8:0] exponent_diff;


logic skip;


logic [28:0] c0;
logic [24:0] c1;
logic [16:0] c2;
logic [`Y_WL-`Y_FL-1:-`Y_FL] y;
logic [2:-23] mantissa;




pre_processor pp(precision,opcode,single_x,single_y,single_z,sign,exponent,exponent_diff,skip,c0,c1,c2,y);

initial begin
	precision=1'b0;
    opcode=`RELU6;
	single_x=32'h000053b7;
	single_y=32'h0000c6e3;
	single_z=32'h00002d00;
	#1
	$display("precision=%b",precision);
	$display("opcode=%b",opcode);
	$display("single_x=%b",single_x);
	$display("single_y=%h",single_y);
	$display("single_z=%h\n",single_z);
	

	$display("exponent=%b",exponent);
	$display("exponent_diff=%d",exponent_diff);


	
	$display("sign=%b",sign);
	$display("skip=%b",skip);
	

	$display("c0=%b",c0);
	$display("c1=%b",c1);
	$display("c2=%b",c2);
	$display("y=%b",y);

	
	$display("test=%d",pp.exponent_xy);
	$display("test=%d",pp.exponent_z);
	

end
endmodule
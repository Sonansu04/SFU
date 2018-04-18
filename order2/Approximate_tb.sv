`include "Approximate.sv"

module tb;
logic [2:-23] input_x;
logic signed [`C0_WL-`C0_FL-1:-`C0_FL] c0;
logic signed [`C1_WL-`C1_FL-1:-`C1_FL] c1;
logic signed [`C2_WL-`C2_FL-1:-`C2_FL] c2;
logic signed [`Y_WL-`Y_FL-1:-`Y_FL] y;
logic signed [`A_WL-`A_FL-1:-`A_FL] a;


logic signed [`C1Y_WL-`C1Y_FL-1:-`C1Y_FL] c1y;
logic signed [`C2Y_WL-`C2Y_FL-1:-`C2Y_FL] c2y;

logic signed [3:-46] result;


 logic [3:0] opcode;
 logic signed [2:-46] c0_temp;
 logic signed [2:-46] c1y_temp;
 logic signed [2:-46] c2y_temp;

 
 logic signed [`Y_2_WL-`Y_2_FL-1:-`Y_2_FL] y_2;


 logic skip;
 logic precision;
 
 logic [8:0] exponent_diff;
 
 
 logic signed [2:-27] y_2_temp;
 
Approximate a1(precision,skip,opcode,result,c0,c1,c2,y,exponent_diff,c1y,c0_temp,c2y_temp,c2y,c1y_temp,y_2,y_2_temp);






initial begin
	skip=0;
    opcode=`FMA;
	precision=1'b0;
    c0=29'b11000000101010000000000000000;
	c1=25'b1001000111010000000000000;
	c2=17'b00000000000000000;
	y=25'b0101000000000000000000000;
	exponent_diff=0;

	$display("precision=%b",precision);
	$display("opcode = %b",opcode);
	$display("c0 = %b",c0);
	$display("c1 = %b",c1);
	$display("c2 = %b",c2);
	$display("y = %b\n",y);

	


	#1 $display("exponent_diff=%d\n",exponent_diff);

	
	

	#1 $display("c0=%b",c0);
	#1 $display("c1y=%b",c1y);
	#1 $display("y_2=%b",y_2);
	#1 $display("y_2_temp=%b",y_2_temp);
	
	
	#1 $display("c2y=%b\n",c2y);
	
	
	
	
	#1 $display("c0_temp=%b",c0_temp);
	#1 $display("c1y_temp=%b",c1y_temp);
	#1 $display("c2y_temp=%b\n",c2y_temp);
	
	
	

	#1 $display("result=%b",result);
	
	#1 $display("test=%b",~result+1);
	
end
endmodule


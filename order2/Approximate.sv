
`include "mul_25_25.sv"
`include "mul_30_17.sv"

`define Y_WL	25
`define Y_FL	23

`define X_WL	26
`define X_FL	23



`define C0_WL	29
`define C0_FL	26


`define C1_WL	25
`define C1_FL	23

`define C2_WL	17
`define C2_FL	16



`define A_WL	14
`define A_FL	11


`define C1Y_WL	(`C1_WL+`Y_WL-1)
`define C1Y_FL	(`C1_FL+`Y_FL)

`define Y_2_WL  (2*`Y_WL-1)
`define Y_2_FL  (2*`Y_FL)




`define C2Y_WL	(`C2_WL+30-1)
`define C2Y_FL	(`C2_FL+27)


`define RCP 	4'b0000
`define SQRT 	4'b0001
`define RSQRT 	4'b0010
`define POW2	4'b0011
`define LOG2	4'b0100
`define SIN		4'b0101
`define FMA		4'b0110
`define TANH	4'b0111
`define SIGMOID 4'b1000



module Approximate(precision,skip,opcode,result,c0,c1,c2,y,exponent_diff);

input logic precision;
input logic  [3:0] opcode;

input logic signed [`C0_WL-`C0_FL-1:-`C0_FL] c0;
input logic signed [`C1_WL-`C1_FL-1:-`C1_FL] c1;
input logic signed [`C2_WL-`C2_FL-1:-`C2_FL] c2;

input logic signed [`Y_WL-`Y_FL-1:-`Y_FL] y;



input logic signed [8:0] exponent_diff;


input logic skip;

output logic signed [3:-46] result;


 logic signed [`Y_WL-`Y_FL-1:-`Y_FL] y_temp;

logic signed [`Y_2_WL-`Y_2_FL-1:-`Y_2_FL] y_2;
logic signed [`C1Y_WL-`C1Y_FL-1:-`C1Y_FL] c1y;
logic signed [`C2Y_WL-`C2Y_FL-1:-`C2Y_FL] c2y;
logic signed [2:-46] c0_temp;
logic signed [2:-46] c1y_temp;
logic signed [2:-46] c2y_temp;
logic signed [2:-27] y_2_temp;

logic signed m2_enable;




mul_25_25 m1(!skip,c1,y,c1y);

mul_25_25 m2(m2_enable,y_temp,y_temp,y_2);

mul_30_17 m3(m2_enable,y_2_temp,c2,c2y);


always_comb begin
	if(skip||(opcode==`FMA)||(precision==1'b0))
		m2_enable=1'b0;
	else
		m2_enable=1'b1;
end


always_comb begin
	c0_temp={c0,{20{1'b0}}};
	if(!skip)begin
		if(opcode==`RELU||opcode==`RELU6||opcode==`FMA||precision==1'b0)begin

			c1y_temp={c1y[2:-27],{19{1'b0}}};
			c2y_temp=0;
			y_2_temp=0;
			y_temp=0;
			
			if(exponent_diff>=0)begin
				result=$signed (c0_temp>>>(exponent_diff))+c1y_temp;

			end
			else begin
				result=c0_temp+$signed (c1y_temp>>>(-exponent_diff));

			end
		end
		else begin
			y_temp=y;
			y_2_temp=y_2[2:-27];
			c1y_temp={c1y[2:-27],{19{1'b0}}};
			c2y_temp={c2y[2:-27],{19{1'b0}}};
			result=c0_temp+c1y_temp+c2y_temp;
		end
	end
	else begin
		y_temp=0;
		y_2_temp=0;
		c1y_temp=0;
		c2y_temp=0;
		if(opcode==`FMA)
			result=c0_temp;
		else
			result=0;	
	end

	
end


endmodule


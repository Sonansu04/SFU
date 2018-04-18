`include "R_LUT.sv"
`include "SQRT_LUT.sv"
`include "INV_SQRT_LUT.sv"
`include "POW2_LUT.sv"
`include "LOG2_LUT.sv"
`include "SIN_LUT.sv"
`include "TANH_LUT.sv"


`define RCP 	4'b0000
`define SQRT 	4'b0001
`define RSQRT 	4'b0010
`define POW2	4'b0011
`define LOG2	4'b0100
`define SIN		4'b0101
`define FMA		4'b0110
`define TANH	4'b0111
`define SIGMOID 4'b1000
 

module LUT(opcode,x_msb,c0,c1,c2,a);
input  logic [3:0] opcode;
input  logic [12:0] x_msb;




logic signed [28:0] c0_rcp;
logic signed [24:0] c1_rcp;
logic signed [16:0] c2_rcp;
logic signed [13:0] a_rcp;


//---------c0=[3,26], c1=[1,21], c2=[1,16], a=[3,11]---------//
logic signed [28:0] c0_sqrt;



logic signed [28:0] c0_inv_sqrt;
logic signed [24:0] c1_inv_sqrt;
logic signed [16:0] c2_inv_sqrt;
logic signed [13:0] a_inv_sqrt;


//---------c0=[3,26], c1=[2,20], c2=[1,16], a=[3,11]---------//
logic signed [28:0] c0_pow2;
logic signed [24:0] c1_pow2;
logic signed [16:0] c2_pow2;
logic signed [13:0] a_pow2;



//---------c0=[3,26], c1=[2,20], c2=[1,16], a=[3,11]---------//
logic signed [28:0] c0_log2;
logic signed [24:0] c1_log2;
logic signed [16:0] c2_log2;
logic signed [13:0] a_log2;


//---------c0=[3,26], c1=[2,20], c2=[1,16], a=[3,11]---------//
logic [28:0] c0_sin;
logic [24:0] c1_sin;
logic [16:0] c2_sin;
logic [13:0] a_sin;


//---------c0=[3,26], c1=[2,20], c2=[1,16], a=[3,11]---------//
logic [28:0] c0_tanh;
logic [24:0] c1_tanh;
logic [16:0] c2_tanh;
logic [13:0] a_tanh;




output logic [28:0] c0;
output logic [24:0] c1;
output logic [16:0] c2;
output logic [13:0] a;


	SQRT_LUT SQRT_LUT1(.x_msb(x_msb[11:0]),
	.c0(c0_sqrt));
	
	
	INV_SQRT_LUT INV_SQRT_LUT1(.x_msb(x_msb[11:0]),
	.c0(c0_inv_sqrt),
	.c1(c1_inv_sqrt),
	.c2(c2_inv_sqrt),
	.a(a_inv_sqrt));
	
	
	R_LUT R_LUT1(
	.x_msb(x_msb[11:0]),
	.c0(c0_rcp),
	.c1(c1_rcp),
	.c2(c2_rcp),
	.a(a_rcp));
	
	
	POW2_LUT POW2_LUT1(
	.x_msb(x_msb[11:0]),
	.c0(c0_pow2),
	.c1(c1_pow2),
	.c2(c2_pow2),
	.a(a_pow2));
	
	LOG2_LUT LOG2_LUT1(
	.x_msb(x_msb[11:0]),
	.c0(c0_log2),
	.c1(c1_log2),
	.c2(c2_log2),
	.a(a_log2));
	
	SIN_LUT SIN_LUT1(
	.x_msb(x_msb[11:0]),
	.c0(c0_sin),
	.c1(c1_sin),
	.c2(c2_sin),
	.a(a_sin));
	
	TANH_LUT TANH_LUT1(
	.x_msb(x_msb),
	.c0(c0_tanh),
	.c1(c1_tanh),
	.c2(c2_tanh),
	.a(a_tanh));
	
	
	
	
always_comb begin
	case (opcode)
	`RCP:begin//RCP
		c0=c0_rcp;
		c1=c1_rcp;
		c2=c2_rcp;
		a=a_rcp;
	end
	`SQRT:begin//SQRT
		c0=c0_sqrt;
		c1=$signed (c0_inv_sqrt)>>>4;
		c2=$signed (c1_inv_sqrt)>>>9;
		a=a_inv_sqrt;
	end
	`RSQRT:begin//INV_SQRT
		c0=c0_inv_sqrt;
		c1=c1_inv_sqrt;
		c2=c2_inv_sqrt;
		a=a_inv_sqrt;
	end
	`POW2:begin//POW2_LUT
		c0=c0_pow2;
		c1=c1_pow2;
		c2=c2_pow2;
		a=a_pow2;
	end
	
	`LOG2:begin//log2_LUT
		c0=c0_log2;
		c1=c1_log2;
		c2=c2_log2;
		a=a_log2;
	end
	
	`SIN:begin//SIN_LUT
		c0=c0_sin;
		c1=c1_sin;
		c2=c2_sin;
		a=a_sin;
	end
	
	`TANH:begin//TANH_LUT
		c0=c0_tanh;
		c1=c1_tanh;
		c2=c2_tanh;
		a=a_tanh;
	end
	`SIGMOID:begin
		c0=c0_tanh;
		c1=c1_tanh;
		c2=c2_tanh;
		a=a_tanh;
	end
	
	default:begin
		c0=29'b0;
		c1=25'b0;
		c2=17'b0;
		a=14'b0;
	end
	endcase
end
endmodule		



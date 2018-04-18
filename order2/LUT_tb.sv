`include "LUT.sv"
module LUT_tb;

 logic [3:0] opcode;
 logic [12:0] x_msb;
 logic [28:0] c0;
 logic [24:0] c1;
 logic [16:0] c2;
 logic [13:0] a;

LUT LUT1(.opcode(opcode),
.x_msb(x_msb),
.c0(c0),
.c1(c1),
.c2(c2),
.a(a));

initial begin
	$monitor("opcode=%b\nc0=%b\nc1=%b\nc2=%b\na=%b",opcode,c0,c1,c2,a);
	opcode=`SIGMOID;
	x_msb=13'b0100111111101;
end


endmodule


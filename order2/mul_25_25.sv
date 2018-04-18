module mul_25_25(enable,in1,in2,out);
input logic enable;
input logic signed [24:0] in1;
input logic signed [24:0] in2;
output logic signed [48:0] out;

always_comb begin
	if(enable)
		out=in1*in2;
	else
		out=0;
end
endmodule


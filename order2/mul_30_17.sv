module mul_30_17(enable,in1,in2,out);
input logic enable;
input logic signed [29:0] in1;
input logic signed [16:0] in2;
output logic signed [45:0] out;

always_comb begin
	if(enable)
		out=in1*in2;
	else
		out=0;
end
endmodule



module complement_2(in1,sign,out);
input logic [3:-46] in1;
input logic sign;
output logic [3:-46] out;
	always_comb begin
		if(sign|(in1[3]==1))
			out=~in1+1;
		else
			out=in1;
	end
endmodule
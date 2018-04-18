`include "LOD.sv"
`include "complement_2.sv"



`define RCP 	4'b0000
`define SQRT 	4'b0001
`define RSQRT 	4'b0010
`define POW2	4'b0011
`define LOG2	4'b0100
`define SIN		4'b0101
`define FMA		4'b0110
`define TANH	4'b0111
`define SIGMOID 4'b1000
`define RELU	4'b1001
`define RELU6	4'b1010

module post_processor(precision,opcode,sign,exponent,approximate_result,single_y,skip,single_x);
input logic precision;
input logic [3:0] opcode;
input logic sign;
input logic [7:0] exponent;
input logic signed [3:-46] approximate_result;
input logic [31:0] single_x;
input logic skip;


logic [-1:-23] normalized_result;
logic [7:0] exponent_LOD;
logic [3:-46] denormal_num;

logic [4:0] exponent_FP16;
logic sign_temp;


output logic [31:0] single_y;


always_comb begin

	if(opcode==`TANH)
		sign_temp=0;
	else
		sign_temp=sign;
end








LOD LOD1(
.in(denormal_num[-1:-27]),
.out(normalized_result),
.LOD_num(exponent_LOD));

complement_2 c1(
.in1(approximate_result),
.sign(sign_temp),
.out(denormal_num)
);

always_comb begin

	case(opcode)
	`RCP:begin//rcp
		exponent_FP16=~exponent+8'd15;
		if(precision==1'b1)
			single_y={sign,~exponent+8'd127,approximate_result[-2:-24]};
		else
			single_y={sign,exponent_FP16,approximate_result[-2:-11]};

	end
	`SQRT:begin//SQRT
		exponent_FP16=exponent+8'd15;
		if(precision==1'b1)
			single_y={sign,exponent+8'd127,approximate_result[-1:-23]};
		else
			single_y={sign,exponent_FP16,approximate_result[-1:-10]};

	end
	`RSQRT:begin//INV_SQRT
		exponent_FP16=~exponent+8'd15;
		if(precision==1'b1)
			single_y={sign,~exponent+8'd127,approximate_result[-2:-24]};
		else
			single_y={sign,exponent_FP16,approximate_result[-2:-11]};

	end
	`POW2:begin//POW2
		if(precision==1'b1)begin
			single_y={1'b0,exponent+8'd127,approximate_result[-1:-23]};
			exponent_FP16=0;
		end
		else begin
			if(sign&skip)begin
				exponent_FP16=exponent+8'd16;
				single_y={1'b0,exponent_FP16,approximate_result[-1:-10]};
			end
			else begin
				exponent_FP16=exponent+8'd15;
				single_y={1'b0,exponent_FP16,approximate_result[-1:-10]};
			end
		end

	end
	`LOG2:begin//LOG2
	
		if(precision==1'b1) begin
			exponent_FP16=0;
			if(single_x==32'b00111111100000000000000000000000)
				single_y=32'b0;
			else if(sign==0)begin//postive
				casez (exponent)
					8'b01??????:begin
						single_y={sign,8'd133,exponent[5:0],approximate_result[-1:-17]};
					end
					8'b001?????:begin
						single_y={sign,8'd132,exponent[4:0],approximate_result[-1:-18]};
					end
					8'b0001????:begin
						single_y={sign,8'd131,exponent[3:0],approximate_result[-1:-19]};
					end
					8'b00001???:begin
						single_y={sign,8'd130,exponent[2:0],approximate_result[-1:-20]};
					end
					8'b000001??:begin
						single_y={sign,8'd129,exponent[1:0],approximate_result[-1:-21]};
					end
					8'b0000001?:begin
						single_y={sign,8'd128,exponent[0],approximate_result[-1:-22]};
					end
					8'b00000001:begin
						single_y={sign,8'd127,approximate_result[-1:-23]};
					end
					8'b00000000:begin
						single_y={sign,exponent_LOD,normalized_result};
					end
					default:single_y=32'b0;
				endcase
			end
			else begin
				casez (exponent)
				8'b01??????:begin
					single_y={sign,8'd133,exponent[5:0],denormal_num[-1:-17]};
				end
				8'b001?????:begin
					single_y={sign,8'd132,exponent[4:0],denormal_num[-1:-18]};
				end
				8'b0001????:begin
					single_y={sign,8'd131,exponent[3:0],denormal_num[-1:-19]};
				end
				8'b00001???:begin
					single_y={sign,8'd130,exponent[2:0],denormal_num[-1:-20]};
				end
				8'b000001??:begin
					single_y={sign,8'd129,exponent[1:0],denormal_num[-1:-21]};
				end
				8'b0000001?:begin
					single_y={sign,8'd128,exponent[0],denormal_num[-1:-22]};
				end
				8'b00000001:begin
					single_y={sign,8'd127,denormal_num[-1:-23]};
				end
				8'b00000000:begin
					single_y={sign,exponent_LOD,normalized_result};
				end
				default:single_y=32'b0;
			endcase
			end
		end
		else begin
			exponent_FP16=exponent_LOD-8'd112;
			if(single_x==32'h00003c00)
				single_y=32'b0;
			else if(sign==0)begin//postive
				
				casez (exponent)
					8'b01??????:begin
						single_y={sign,5'd21,exponent[5:0],approximate_result[-1:-4]};
					end
					8'b001?????:begin
						single_y={sign,5'd20,exponent[4:0],approximate_result[-1:-5]};
					end
					8'b0001????:begin
						single_y={sign,5'd19,exponent[3:0],approximate_result[-1:-6]};
					end
					8'b00001???:begin
						single_y={sign,5'd18,exponent[2:0],approximate_result[-1:-7]};
					end
					8'b000001??:begin
						single_y={sign,5'd17,exponent[1:0],approximate_result[-1:-8]};
					end
					8'b0000001?:begin
						single_y={sign,5'd16,exponent[0],approximate_result[-1:-9]};
					end
					8'b00000001:begin
						single_y={sign,5'd15,approximate_result[-1:-10]};
					end
					8'b00000000:begin
						single_y={sign,exponent_FP16,normalized_result[-1:-10]};
					end
					default:single_y=32'b0;
				endcase
			end
			else begin
				casez (exponent)
				8'b01??????:begin
					single_y={sign,5'd21,exponent[5:0],denormal_num[-1:-4]};
				end
				8'b001?????:begin
					single_y={sign,5'd20,exponent[4:0],denormal_num[-1:-5]};
				end
				8'b0001????:begin
					single_y={sign,5'd19,exponent[3:0],denormal_num[-1:-6]};
				end
				8'b00001???:begin
					single_y={sign,5'd18,exponent[2:0],denormal_num[-1:-7]};
				end
				8'b000001??:begin
					single_y={sign,5'd17,exponent[1:0],denormal_num[-1:-8]};
				end
				8'b0000001?:begin
					single_y={sign,5'd16,exponent[0],denormal_num[-1:-9]};
				end
				8'b00000001:begin
					single_y={sign,5'd15,denormal_num[-1:-10]};
				end
				8'b00000000:begin
					single_y={sign,exponent_FP16,normalized_result[-1:-10]};
				end
				default:single_y=32'b0;
			endcase
			end
		end
		
	end
	`SIN:begin//SIN
	
		exponent_FP16=exponent_LOD-8'd112;
		if(precision==1'b1) begin
		
			if(single_x>=1070139355)
				single_y=32'b00111111100000000000000000000000;
			else if(single_x>=1070137855)
				single_y=32'b00111111011111111111111111111111;
			else if(single_x>=1070137344)
				single_y=32'b00111111011111111111111111111110;
			else if(single_x>=981467136)
				single_y={sign,exponent_LOD,normalized_result};
			else 
				single_y=single_x;
		end
		else begin
			if(single_x>=15920)
				single_y=32'h00003c00;
			else if(single_x>=5120)
				single_y={sign,exponent_FP16,normalized_result[-1:-10]};
			else 
				single_y=single_x;
		end
	end
	
	`FMA:begin //FMA
		if(precision==1'b1)begin
			exponent_FP16=0;
			if(skip==1'b1)
				single_y=single_x;
			else begin
				casez (approximate_result[3:0])
					4'b0000:begin
						single_y={1'b0,exponent+exponent_LOD,normalized_result};
					end
					4'b0001:begin
						single_y={1'b0,exponent+8'd127,approximate_result[-1:-23]};
					end
					4'b001?:begin
						single_y={1'b0,exponent+8'd128,approximate_result[0:-22]};
					end
					
					4'b01??:begin
						single_y={1'b0,exponent+8'd129,approximate_result[1:-21]};
					end
					
					
					4'b1100:begin
						single_y={1'b1,exponent+8'd128,denormal_num[0:-22]};
					end
					4'b1101:begin
						single_y={1'b1,exponent+8'd128,denormal_num[0:-22]};
					end
					4'b1110:begin
						single_y={1'b1,exponent+8'd127,denormal_num[-1:-23]};
					end
					4'b1111:begin
						single_y={1'b1,exponent+exponent_LOD,normalized_result};
					end
					default:single_y=32'b0;
					endcase
			end
		end
		else begin

			if(skip==1'b1)begin
				exponent_FP16=0;
				single_y=single_x;
			end
			else begin
				
				casez (approximate_result[3:0])
				
					4'b0000:begin
						exponent_FP16=exponent+exponent_LOD-8'd112;
						single_y={1'b0,exponent_FP16,normalized_result[-1:-10]};
					end
					4'b0001:begin
						exponent_FP16=exponent+8'd15;
						single_y={1'b0,exponent_FP16,approximate_result[-1:-10]};
					end
					4'b001?:begin
						exponent_FP16=exponent+8'd16;
						single_y={1'b0,exponent_FP16,approximate_result[0:-9]};
					end
					4'b01??:begin
						exponent_FP16=exponent+8'd17;
						single_y={1'b0,exponent_FP16,approximate_result[1:-8]};
					end
					
					4'b1000:begin
						exponent_FP16=exponent+8'd16;
						single_y={1'b1,exponent_FP16,denormal_num[0:-9]};
					end
					
					4'b1001:begin
						exponent_FP16=exponent+8'd17;
						single_y={1'b1,exponent_FP16,denormal_num[1:-8]};
					end
					
					4'b1010:begin
						exponent_FP16=exponent+8'd17;
						single_y={1'b1,exponent_FP16,denormal_num[1:-8]};
					end
					
					
					4'b1011:begin
						exponent_FP16=exponent+8'd17;
						single_y={1'b1,exponent_FP16,denormal_num[1:-8]};
					end
					
					4'b1100:begin
						exponent_FP16=exponent+8'd16;
						single_y={1'b1,exponent_FP16,denormal_num[0:-9]};
					end
					4'b1101:begin
						exponent_FP16=exponent+8'd16;
						single_y={1'b1,exponent_FP16,denormal_num[0:-9]};
					end
					4'b1110:begin
						exponent_FP16=exponent+8'd15;
						single_y={1'b1,exponent_FP16,denormal_num[-1:-10]};
					end
					4'b1111:begin
						exponent_FP16=exponent+exponent_LOD-8'd112;
						single_y={1'b1,exponent_FP16,normalized_result[-1:-10]};
					end
					default:begin
						exponent_FP16=0;
						single_y=32'b0;
					end
					endcase
			end
		
		end
	end
	
	
	`TANH:begin //TANH
		if(precision==1'b1)begin
			exponent_FP16=0;
			if(skip==1'b1)
				single_y={sign,31'b0111111100000000000000000000000};
			else 
				single_y={sign,exponent_LOD,normalized_result};
		end 
		else begin
			exponent_FP16=exponent_LOD-8'd112;
			if(skip==1'b1)
				single_y={sign,15'b011110000000000};
			else 
				single_y={sign,exponent_FP16,normalized_result[-1:-10]};
		end
	end
	
	
	`SIGMOID:begin //TANH
	

		case ({precision,sign,skip})
		3'b000:begin
			exponent_FP16=0;
			single_y={sign,8'd14,approximate_result[-1:-10]};
		end
		3'b001:begin
			exponent_FP16=0;
			if(~|single_x)
				single_y=32'b00000000000000000011100000000000;
			else
				single_y=32'b00000000000000000011110000000000;
		end
		3'b010:begin
			exponent_FP16=exponent_LOD-113;
			single_y={1'b0,exponent_FP16,normalized_result[-1:-10]};
		
		end
		3'b011:begin
			exponent_FP16=0;
			single_y=32'b0;
		end
		
		
		
		
	
		3'b100:begin
			exponent_FP16=0;
			single_y={sign,8'd126,approximate_result[-1:-23]};
		end
		3'b101:begin
			exponent_FP16=0;
			if(~|single_x)
				single_y=32'b00111111000000000000000000000000;
			else
				single_y=32'b00111111100000000000000000000000;
		end
		3'b110:begin
			exponent_FP16=0;
			single_y={1'b0,exponent_LOD-1,normalized_result};
		
		end
		3'b111:begin
			exponent_FP16=0;
			single_y=32'b0;
		end
		default:begin
			exponent_FP16=0;
			single_y=32'b0;	
		end
		


		endcase
			
	end
	
	`RELU:begin
		exponent_FP16=0;
		if(sign)
			single_y=32'b0;
		else
			single_y=single_x;
	end
	
	`RELU6:begin
		exponent_FP16=0;
		if(sign)
				single_y=32'b0;
		else begin
				casez(exponent)
				8'b1???????:begin
					single_y=single_x;
				end
				8'b00000000:begin
					single_y=single_x;
				end
				8'b00000001:begin
					single_y=single_x;
				end
				8'b00000010:begin
					if(single_x[22]&precision)
						single_y=32'b01000000110000000000000000000000;
					else if(single_x[9]&(!precision))
						single_y=32'b00000000000000000100011000000000;
					else
						single_y=single_x;
				end
				default:begin
					if(precision)
						single_y=32'b01000000110000000000000000000000;
					else
						single_y=32'b00000000000000000100011000000000;
				end
				endcase
		end
	end
		

	
	
	default:begin
		exponent_FP16=0;
		single_y=32'b0;
	end
	
	endcase
end
endmodule




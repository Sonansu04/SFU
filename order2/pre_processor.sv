`include "LUT.sv"

`define Y_WL	25
`define Y_FL	23



`define RCP 	4'b0000
`define SQRT 	4'b0001
`define RSQRT 	4'b0010
`define POW2	4'b0011
`define LOG2	4'b0100
`define SIN		4'b0101
`define FMA		4'b0110
`define TANH	4'b0111
`define SIGMOID 4'b1000
`define RELU    4'b1001
`define RELU6	4'b1010





module pre_processor(precision,opcode,single_x,single_y,single_z,sign,exponent,exponent_diff,skip,c0,c1,c2,y);
input logic [3:0] opcode;
input logic [31:0] single_x;
input logic [31:0] single_y;
input logic [31:0] single_z;
input logic precision;
output logic sign;
output logic signed [7:0] exponent;
output logic skip;

output logic [28:0] c0;
output logic [24:0] c1;
output logic [16:0] c2;
output logic [`Y_WL-`Y_FL-1:-`Y_FL] y;


logic [2:-23] mantissa;
logic [13:0] a;
logic [7:0] POW2_I;
logic [2:-23] a_exetn;



logic [28:0] c0_LUT;
logic [24:0] c1_LUT;
logic [16:0] c2_LUT;

logic signed [8:0] exponent_xy;
logic signed [8:0] exponent_z;
output logic signed [8:0] exponent_diff;




always_comb begin

	a_exetn = {a,{12{1'b0}}};
	
	if(precision==1'b1)
		POW2_I={{2'b01},single_x[22:17]};
	else
		POW2_I={{2'b01},single_x[9:7],3'b000};
		
	case(opcode)
	`RCP:begin//RCP
		if(precision==1'b1) begin
			mantissa={{3'b001},single_x[22:0]};
			exponent=(single_x[30:23]-8'd127);
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
			sign=single_x[31];
			skip=0;
			c0=c0_LUT;
			c1=c1_LUT;
			c2=c2_LUT;
			y=mantissa-a_exetn;
		end
		else begin
			mantissa={{3'b001},single_x[9:0],{13{1'b0}}};
			exponent={{3'b000},single_x[14:10]}-8'd15;
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
			sign=single_x[15];
			skip=0;
			c0=c0_LUT;
			c1=c1_LUT;
			c2=0;
			y=mantissa-a_exetn;
		
		end
		
	end
	`SQRT:begin//SQRT
		if(precision==1'b1)begin
			if(single_x[23]==1'b1) begin  //EXP=EVEN
				mantissa={{3'b001},single_x[22:0]};
				exponent=$signed(single_x[30:23]-8'd127)>>>1;
				sign=single_x[31];
				skip=0;
			end
			else begin
				mantissa={{2'b01},single_x[22:0],{1'b0}}; //EXP=ODD
				exponent=$signed(single_x[30:23]-8'd128)>>>1;
				sign=single_x[31];
				skip=0;
			end
			c0=c0_LUT;
			c1=c1_LUT;
			c2=c2_LUT;
			y=mantissa-a_exetn;
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
		end
		else begin
			if(single_x[10]==1'b1) begin  //EXP=EVEN
				mantissa={{3'b001},single_x[9:0],{13{1'b0}}};
				exponent=$signed({3'b000,single_x[14:10]}-8'd15)>>>1;
				sign=single_x[15];
				skip=0;
			end
			else begin
				mantissa={{2'b01},single_x[9:0],{14{1'b0}}};
				exponent=$signed({3'b000,single_x[14:10]}-8'd16)>>>1;
				sign=single_x[15];
				skip=0;
			end
			c0=c0_LUT;
			c1=c1_LUT;
			c2=0;
			y=mantissa-a_exetn;
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
		
		
		
		end
	end
	`RSQRT:begin//INV_SQRT
		if(precision==1'b1)begin
			if(single_x[23]==1'b1) begin  //EXP=EVEN
				mantissa={{3'b001},single_x[22:0]};
				exponent=$signed(single_x[30:23]-8'd127)>>>1;
				sign=single_x[31];
				skip=0;
			end
			else begin
				mantissa={{2'b01},single_x[22:0],{1'b0}}; //EXP=ODD
				exponent=$signed(single_x[30:23]-8'd128)>>>1;
				sign=single_x[31];
				skip=0;
			end
			c0=c0_LUT;
			c1=c1_LUT;
			c2=c2_LUT;
			y=mantissa-a_exetn;
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
		end
		else begin
			if(single_x[10]==1'b1) begin  //EXP=EVEN
				mantissa={{3'b001},single_x[9:0],{13{1'b0}}};
				exponent=$signed({3'b000,single_x[14:10]}-8'd15)>>>1;
				sign=single_x[15];
				skip=0;
			end
			else begin
				mantissa={{2'b01},single_x[9:0],{14{1'b0}}}; //EXP=ODD
				exponent=$signed({3'b000,single_x[14:10]}-8'd16)>>>1;
				sign=single_x[15];
				skip=0;
			end
			c0=c0_LUT;
			c1=c1_LUT;
			c2=0;
			y=mantissa-a_exetn;
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
		end
	end
	`POW2:begin//POW2
		if(precision==1'b1) begin
			if(single_x[31]==0)begin //POSITIVE
				if(single_x[30]==1)begin //(E-127)>=1
					exponent=POW2_I>>(8'd133-single_x[30:23]);
					mantissa={{3'b000},{single_x[22:0]<<(single_x[30:23]-8'd127)}};
					sign=1'b0;
					skip=0;
				end
				else if(single_x[30:23]==8'b01111111)begin //(E-127)=0
					exponent=8'b00000001;
					mantissa={{3'b000},single_x[22:0]};
					sign=1'b0;
					skip=0;
				end
				else begin//(E-127)<0
					exponent=8'b00000000;
					mantissa={{2'b00},{1'b1,single_x[22:0]}>>(8'd127-single_x[30:23])};
					sign=1'b0;
					skip=0;
				end
			end
			else
				if(single_x[30]==1)begin //(E-127)>=1
					exponent=~(POW2_I>>(8'd133-single_x[30:23]));
					mantissa=26'b00100000000000000000000000-{{3'b000},{single_x[22:0]<<(single_x[30:23]-8'd127)}};
					sign=1'b0;
					skip=0;
				end
				else if(single_x[30:23]==8'b01111111)begin //(E-127)=0
					exponent=8'b11111110;
					mantissa=26'b00100000000000000000000000-{{3'b000},single_x[22:0]};
					sign=1'b0;
					skip=0;
				end
				else begin//(E-127)<0
					exponent=8'b11111111;
					mantissa=26'b00100000000000000000000000-{{2'b00},{1'b1,single_x[22:0]}>>(8'd127-single_x[30:23])};
					sign=1'b0;
					skip=0;
				end	
			c0=c0_LUT;
			c1=c1_LUT;
			c2=c2_LUT;
			y=mantissa-a_exetn;
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
		end
		else begin
			if(single_x[15]==0)begin //POSITIVE
				if(single_x[14]==1)begin //(E-15)>=1
					exponent=POW2_I>>(8'd21-{3'b000,single_x[14:10]});
					mantissa={{3'b000},{({single_x[9:0],{13{1'b0}}})<<({3'b000,single_x[14:10]}-8'd15)}};
					sign=1'b0;
					
				end
				else if(single_x[14:10]==5'b01111)begin //(E-15)=0
					exponent=8'b00000001;
					mantissa={{3'b000},single_x[9:0],{13{1'b0}}};
					sign=1'b0;
				
				end
				else begin//(E-15)<0
					exponent=8'b00000000;
					mantissa={{2'b00},{1'b1,single_x[9:0],{13{1'b0}}}>>(8'd15-{3'b000,single_x[14:10]})};
					sign=1'b0;
				
				end
			end
			else
				if(single_x[14]==1)begin //(E-15)>=1
					exponent=~(POW2_I>>(8'd21-{3'b000,single_x[14:10]}));
					mantissa=26'b00100000000000000000000000-{{3'b000},{({single_x[9:0],{13{1'b0}}})<<({3'b000,single_x[14:10]}-8'd15)}};
					sign=1'b1;
				
				end
				else if(single_x[14:10]==5'b01111)begin //(E-127)=0
					exponent=8'b11111110;
					mantissa=26'b00100000000000000000000000-{{3'b000},single_x[9:0],{13{1'b0}}};
					sign=1'b1;
				
				end
				else begin//(E-127)<0
					exponent=8'b11111111;
					mantissa=26'b00100000000000000000000000-{{2'b00},{1'b1,single_x[9:0],{13{1'b0}}}>>(8'd15-{3'b000,single_x[14:10]})};
					sign=1'b0;
				
				end	
				
			if(mantissa[-1:-10]==10'd0)
				skip=1;
			else
				skip=0;
			
			c0=c0_LUT;
			c1=c1_LUT;
			c2=0;
			y=mantissa-a_exetn;
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;

		end
	end	
	`LOG2:begin//LOG2
		if(precision==1'b1) begin
			mantissa={{3'b001},single_x[22:0]};
			if(single_x[30:23]==8'b01111111||single_x[30]==1'b1) begin //EXP=0
				exponent=(single_x[30:23]-8'd127);
				sign=1'b0;
				skip=0;
			end
			else begin //EXP<=-1
				exponent=~(single_x[30:23]-8'd127);
				sign=1'b1;
				skip=0;
			end
			c0=c0_LUT;
			c1=c1_LUT;
			c2=c2_LUT;
			y=mantissa-a_exetn;
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
		end
		else begin
			mantissa={{3'b001},single_x[9:0],{13{1'b0}}};
			if(single_x[14:10]==5'b01111||single_x[14]==1'b1) begin //EXP=0
				exponent=({3'b000,single_x[14:10]}-8'd15);
				sign=1'b0;
				skip=0;
			end
			else begin //EXP<=-1
				exponent=~({3'b000,single_x[14:10]}-8'd15);
				sign=1'b1;
				skip=0;
			end
			c0=c0_LUT;
			c1=c1_LUT;
			c2=0;
			y=mantissa-a_exetn;
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
		
		end
		
	end
	`SIN:begin
		if(precision==1'b1)begin
			if(single_x>32'd981467136)begin
				mantissa={{2'b00},{{1'b1},single_x[22:0]}>>(8'd127-single_x[30:23])};
				exponent=8'd0;
				sign=1'b0;
				skip=0;
			end
			else begin
				exponent=8'd0;
				mantissa=26'd0;
				sign=1'b0;
				skip=1;
			end
			c0=c0_LUT;
			c1=c1_LUT;
			c2=c2_LUT;
			y=mantissa-a_exetn;
			
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
		end
		else begin
			if(single_x>32'd5120)begin
				mantissa={{2'b00},{{1'b1},single_x[9:0],{13{1'b0}}}>>(8'd15-single_x[14:10])};
				exponent=8'd0;
				sign=1'b0;
				skip=0;
			end
			else begin
				exponent=8'd0;
				mantissa=26'd0;
				sign=1'b0;
				skip=1;
			end
			c0=c0_LUT;
			c1=c1_LUT;
			c2=0;
			y=mantissa-a_exetn;
			
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
		
		end
	end
	`FMA:begin //FMA  x*y+z  y*z+x
		if (precision==1'b1)begin
			mantissa=0;
			sign=0;
			if(single_y[30:23]==8'b0||single_z[30:23]==8'b0)begin
				exponent_xy=0;
				exponent_diff=0;
				exponent_z=0;
				exponent=0;
				skip=1;
			end
			else begin
				skip=0;
				exponent_xy=(single_y[30:23]-8'd127)+(single_z[30:23]-8'd127);
				exponent_z={1'b0,single_x[30:23]}-9'd127;
				exponent_diff=exponent_xy-exponent_z;
				exponent=(exponent_xy>=exponent_z)?exponent_xy:exponent_z;
			end	
			if(single_y[31]==1'b1)
				c1={~{{2'b01},single_y[22:0]}+1};
			else
				c1={{2'b01},single_y[22:0]};
			c2=0;
			
			if(single_z[31]==1'b1)
				y={~{{2'b01},single_z[22:0]}+1};
			else
				y={{2'b01},single_z[22:0]};
			
			
			if(single_x[31]==1'b1)
				c0={~{{3'b001},single_x[22:0],{3{1'b0}}}+1};
			else
				c0={{3'b001},single_x[22:0],{3{1'b0}}};	
		end

		else begin
			mantissa=0;
			sign=0;
			if(single_y[14:10]==5'b0||single_z[14:10]==5'b0)begin
				exponent_xy=0;
				exponent_diff=0;
				exponent_z=0;
				exponent=0;
				skip=1;
			end
			else begin
				skip=0;
				exponent_xy=({3'b000,single_y[14:10]}-8'd15)+({3'b000,single_z[14:10]}-8'd15);
				exponent_z={4'b0000,single_x[14:10]}-9'd15;
				exponent_diff=exponent_xy-exponent_z;
				exponent=(exponent_xy>=exponent_z)?exponent_xy:exponent_z;
			end	
			if(single_y[15]==1'b1)
				c1={~{{2'b01},single_y[9:0],{13{1'b0}}}+1};
			else
				c1={{2'b01},single_y[9:0],{13{1'b0}}};
			

			c2=0;
			
			
			if(single_z[15]==1'b1)
				y={~{{2'b01},single_z[9:0],{13{1'b0}}}+1};
			else
				y={{2'b01},single_z[9:0],{13{1'b0}}};
			
			
			if(single_x[15]==1'b1)
				c0={~{{3'b001},single_x[9:0],{16{1'b0}}}+1};
			else
				c0={{3'b001},single_x[9:0],{16{1'b0}}};
				
			end
		end
	
	
	`TANH:begin
		if(precision==1'b1)begin
			sign=single_x[31];
			exponent=(single_x[30:23]-8'd127);
			if(exponent>=3)
				skip=1;
			else
				skip=0;
				
			if(exponent[7]==0)
				mantissa={{3'b001},single_x[22:0]}<<exponent;
			else
				mantissa={{3'b001},single_x[22:0]}>>-exponent;
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
			c0=c0_LUT;
			c1=c1_LUT;
			c2=c2_LUT;
			y=mantissa-a_exetn;
		end
		else begin
			sign=single_x[15];
			exponent=({3'b000,single_x[14:10]}-8'd15);

			if(exponent>=3)
				skip=1;
			else
				skip=0;
				
			if(exponent[7]==0)
				mantissa={{3'b001},single_x[9:0],{13{1'b0}}}<<exponent;
			else
				mantissa={{3'b001},single_x[9:0],{13{1'b0}}}>>-exponent;
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
			c0=c0_LUT;
			c1=c1_LUT;
			c2=0;
			y=mantissa-a_exetn;
		end
	end
	
	`SIGMOID:begin
		if(precision==1'b1)begin
			sign=single_x[31];
			exponent=(single_x[30:23]-8'd128);
			if(exponent>=3||single_x==32'b0)
				skip=1;
			else
				skip=0;
				
			if(exponent[7]==0)
				mantissa={{3'b001},single_x[22:0]}<<(exponent);
			else
				mantissa={{3'b001},single_x[22:0]}>>-(exponent);
				
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
			c0=c0_LUT;
			c1=c1_LUT;
			c2=c2_LUT;
			y=mantissa-a_exetn;
		end
		else begin
			sign=single_x[15];
			exponent=({3'b000,single_x[14:10]}-8'd16);
			if(exponent>=3||single_x==32'b0)
				skip=1;
			else
				skip=0;
				
			if(exponent[7]==0)
				mantissa={{3'b001},single_x[9:0],{13{1'b0}}}<<(exponent);
			else
				mantissa={{3'b001},single_x[9:0],{13{1'b0}}}>>-(exponent);
				
			exponent_xy=0;
			exponent_z=0;
			exponent_diff=0;
			c0=c0_LUT;
			c1=c1_LUT;
			c2=0;
			y=mantissa-a_exetn;	
		end
	end
	
	`RELU:begin
		if(precision==1'b1)
			sign=single_x[31];
		else
			sign=single_x[15];
		exponent=8'd0;
		exponent_xy=0;
		exponent_z=0;
		exponent_diff=0;
		mantissa=26'd0;
		skip=1;
		c0=0;
		c1=0;
		c2=0;
		y=0;
	end
    `RELU6:begin
		if(precision==1'b1)	begin
			sign=single_x[31];
			exponent=(single_x[30:23]-8'd127);
		end
		else begin
			sign=single_x[15];
			exponent=({3'b000,single_x[14:10]}-8'd15);
		end
		exponent_xy=0;
		exponent_z=0;
		exponent_diff=0;
		mantissa=26'd0;
		skip=1;
		c0=0;
		c1=0;
		c2=0;
		y=0;
	end
	
	
	default:begin
		exponent=8'd0;
		exponent_xy=0;
		exponent_z=0;
		exponent_diff=0;
		mantissa=26'd0;
		sign=1'b0;
		skip=0;
		c0=0;
		c1=0;
		c2=0;
		y=0;
	end
	
	
	endcase	
	

end



LUT LUT1(.opcode(opcode),
.x_msb(mantissa[2:-10]),
.c0(c0_LUT),
.c1(c1_LUT),
.c2(c2_LUT),
.a(a));

endmodule	





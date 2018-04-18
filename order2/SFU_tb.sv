`timescale 1ns/10ps

`define PERIOD 2.5




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



`ifdef syn
	`include "SFU_v1_syn40.v"
	`include "sc9_cln40g_base_rvt_neg.v"
	`include "sc9_cln40g_base_rvt.v"
	`include "sc9_cln40g_base_rvt_udp.v"
`elsif test
	`include "SFU_test_syn40.v"
	`include "sc9_cln40g_base_rvt_neg.v"
	`include "sc9_cln40g_base_rvt.v"
	`include "sc9_cln40g_base_rvt_udp.v"
`else
	`include "SFU_top.sv"
	
`endif


module SFU_tb;
	
integer sample_sum;

logic [31:0] input1_sample [0:8000000-1];
logic [31:0] input2_sample [0:8000000-1];
logic [31:0] input3_sample [0:8000000-1];

logic [31:0] golden [0:8000000-1];
logic [31:0] output_sample;


logic [31:0] temp;

logic [31:0] error;
logic precision;

logic [31:0] single_x;
logic [31:0] single_y;
logic [31:0] single_z;

logic [31:0] single_result;

logic [3:0] opcode;

logic CLK;
integer fp_w,i,gold;


initial begin
   `ifdef rcp_fp32
		$readmemh("./benchmark/rcp/input_rcp_tb_fp32.dat",input3_sample);
		$readmemh("./benchmark/rcp/output_rcp_tb_fp32.dat",golden);
		opcode=`RCP;
		sample_sum=10000;//8000000;
		precision=1;
		$dumpfile("./waveform/rcp_fp32.vcd");
		$dumpvars;
	`elsif rcp_fp16
		$readmemh("./benchmark/rcp/input_rcp_tb_fp16.dat",input3_sample);
		$readmemh("./benchmark/rcp/output_rcp_tb_fp16.dat",golden);
		opcode=`RCP;
		sample_sum=10000;
		precision=0;
		$dumpfile("./waveform/rcp_fp16.vcd");
		$dumpvars;
		
	`elsif sqrt_fp32            
		$readmemh("./benchmark/sqrt/input_sqrt_tb_fp32.dat",input3_sample);
		$readmemh("./benchmark/sqrt/output_sqrt_tb_fp32.dat",golden);
		opcode=`SQRT;
		sample_sum=10000;//327936;
		precision=1;
		$dumpfile("./waveform/sqrt_fp32.vcd");
		$dumpvars;
		
	`elsif sqrt_fp16
		$readmemh("./benchmark/sqrt/input_sqrt_tb_fp16.dat",input3_sample);
		$readmemh("./benchmark/sqrt/output_sqrt_tb_fp16.dat",golden);
		opcode=`SQRT;
		sample_sum=10000;
		precision=0;
		$dumpfile("./waveform/sqrt_fp16.vcd");
		$dumpvars;
		
		
	`elsif rsqrt_fp32
		$readmemh("./benchmark/rsqrt/input_rsqrt_tb_fp32.dat",input3_sample);
		$readmemh("./benchmark/rsqrt/output_rsqrt_tb_fp32.dat",golden);
		opcode=`RSQRT;
		sample_sum=10000;//100000;
		precision=1'b1;
		$dumpfile("./waveform/rsqrt_fp32.vcd");
		$dumpvars;
		
		
		
	`elsif rsqrt_fp16
		$readmemh("./benchmark/rsqrt/input_rsqrt_tb_fp16.dat",input3_sample);
		$readmemh("./benchmark/rsqrt/output_rsqrt_tb_fp16.dat",golden);
		opcode=`RSQRT;
		sample_sum=10000;
		precision=0;
		$dumpfile("./waveform/rsqrt_fp16.vcd");
		$dumpvars;
		
		
	`elsif pow2_fp32
		$readmemh("./benchmark/pow2/input_pow2_tb_fp32.dat",input3_sample);
		$readmemh("./benchmark/pow2/output_pow2_tb_fp32.dat",golden);
		opcode=`POW2;
		sample_sum=10000;//1579008;
		precision=1;
		$dumpfile("./waveform/pow2_fp32.vcd");
		$dumpvars;
		
		
		
		
	`elsif pow2_fp16
		$readmemh("./benchmark/pow2/input_pow2_tb_fp16.dat",input3_sample);
		$readmemh("./benchmark/pow2/output_pow2_tb_fp16.dat",golden);
		opcode=`POW2;
		sample_sum=10000;//100000;
		precision=0;
		$dumpfile("./waveform/pow2_fp16.vcd");
		$dumpvars;
		
		
		
		
		
	`elsif log2_fp32
		$readmemh("./benchmark/log2/input_log2_tb_fp32.dat",input3_sample);
		$readmemh("./benchmark/log2/output_log2_tb_fp32.dat",golden);
		opcode=`LOG2;
		sample_sum=10000;//4000000;
		precision=1;
		$dumpfile("./waveform/log2_fp32.vcd");
		$dumpvars;
		
		
	`elsif log2_fp16
		$readmemh("./benchmark/log2/input_log2_tb_fp16.dat",input3_sample);
		$readmemh("./benchmark/log2/output_log2_tb_fp16.dat",golden);
		opcode=`LOG2;
		sample_sum=10000;//100000;
		precision=0;
		$dumpfile("./waveform/log2_fp16.vcd");
		$dumpvars;
		
		
	`elsif sin_fp32
		$readmemh("./benchmark/sin/input_sin_tb_fp32.dat",input3_sample);
		$readmemh("./benchmark/sin/output_sin_tb_fp32.dat",golden);
		opcode=`SIN;
		sample_sum=10000;//8000000;
		precision=1'b1;
		$dumpfile("./waveform/sin_fp32.vcd");
		$dumpvars;
		
	`elsif sin_fp16
		$readmemh("./benchmark/sin/input_sin_tb_fp16.dat",input3_sample);
		$readmemh("./benchmark/sin/output_sin_tb_fp16.dat",golden);
		opcode=`SIN;
		sample_sum=10000;//100000;
		precision=1'b0;
		$dumpfile("./waveform/sin_fp16.vcd");
		$dumpvars;
		
		
	`elsif fma_fp32
		$readmemh("./benchmark/fma/input1_fma_tb_fp32.dat",input1_sample);
		$readmemh("./benchmark/fma/input2_fma_tb_fp32.dat",input2_sample);
		$readmemh("./benchmark/fma/input3_fma_tb_fp32.dat",input3_sample);
		$readmemh("./benchmark/fma/output_fma_tb_fp32.dat",golden);
		opcode=`FMA;
		sample_sum=10000;//2368512;	
		precision=1'b1;
		$dumpfile("./waveform/fma_fp32.vcd");
		$dumpvars;
		
		
		
		
		
	`elsif fma_fp16
		$readmemh("./benchmark/fma/input1_fma_tb_fp16.dat",input1_sample);
		$readmemh("./benchmark/fma/input2_fma_tb_fp16.dat",input2_sample);
		$readmemh("./benchmark/fma/input3_fma_tb_fp16.dat",input3_sample);
		$readmemh("./benchmark/fma/output_fma_tb_fp16.dat",golden);
		opcode=`FMA;
		sample_sum=10000;//1000000;	
		precision=1'b0;	
		$dumpfile("./waveform/fma_fp16.vcd");
		$dumpvars;
		
	`elsif tanh_fp32
		$readmemh("./benchmark/tanh/input_tanh_tb_fp32.dat",input3_sample);
		$readmemh("./benchmark/tanh/output_tanh_tb_fp32.dat",golden);
		opcode=`TANH;
		sample_sum=10000;//1000000;
		precision=1'b1;
		$dumpfile("./waveform/tanh_fp32.vcd");
		$dumpvars;
		
		
	`elsif tanh_fp16
		$readmemh("./benchmark/tanh/input_tanh_tb_fp16.dat",input3_sample);
		$readmemh("./benchmark/tanh/output_tanh_tb_fp16.dat",golden);
		opcode=`TANH;
		sample_sum=10000;//100000;
		precision=1'b0;
		$dumpfile("./waveform/tanh_fp16.vcd");
		$dumpvars;
	
	
	
	
	`elsif sigmoid_fp32
		$readmemh("./benchmark/sigmoid/input_sigmoid_tb_fp32.dat",input3_sample);
		$readmemh("./benchmark/sigmoid/output_sigmoid_tb_fp32.dat",golden);
		opcode=`SIGMOID;
		sample_sum=10000;//1000000;
		precision=1'b1;
		$dumpfile("./waveform/sigmoid_fp32.vcd");
		$dumpvars;
		

	
	`elsif sigmoid_fp16
		$readmemh("./benchmark/sigmoid/input_sigmoid_tb_fp16.dat",input3_sample);
		$readmemh("./benchmark/sigmoid/output_sigmoid_tb_fp16.dat",golden);
		opcode=`SIGMOID;
		sample_sum=10000;//100000;
		precision=1'b0;
		$dumpfile("./waveform/sigmoid_fp16.vcd");
		$dumpvars;

	
	`elsif relu_fp32
		$readmemh("./benchmark/relu/input_relu_tb_fp32.dat",input3_sample);
		$readmemh("./benchmark/relu/output_relu_tb_fp32.dat",golden);
		opcode=`RELU;
		sample_sum=10000;//100000;
		precision=1'b1;	
		$dumpfile("./waveform/relu_fp32.vcd");
		$dumpvars;
		
		
		
	`elsif relu_fp16
		$readmemh("./benchmark/relu/input_relu_tb_fp16.dat",input3_sample);
		$readmemh("./benchmark/relu/output_relu_tb_fp16.dat",golden);
		opcode=`RELU;
		sample_sum=10000;//100000;
		precision=1'b0;		
		$dumpfile("./waveform/relu_fp16.vcd");
		$dumpvars;
		
		
		
		
	`elsif relu6_fp32
		$readmemh("./benchmark/relu6/input_relu6_tb_fp32.dat",input3_sample);
		$readmemh("./benchmark/relu6/output_relu6_tb_fp32.dat",golden);
		opcode=`RELU6;
		sample_sum=10000;//100000;
		precision=1'b1;	
		$dumpfile("./waveform/relu6_fp32.vcd");
		$dumpvars;


		
		
	`elsif relu6_fp16
		$readmemh("./benchmark/relu6/input_relu6_tb_fp16.dat",input3_sample);
		$readmemh("./benchmark/relu6/output_relu6_tb_fp16.dat",golden);
		opcode=`RELU6;
		sample_sum=10000;//100000;
		precision=1'b0;		
		$dumpfile("./waveform/relu6_fp16.vcd");
		$dumpvars;
	`endif
	
	
	
end
 
SFU_top SFU1(
.precision(precision),
.opcode(opcode),
.single_x(single_x),
.single_y(single_y),
.single_z(single_z),
.single_result(single_result));


always_comb begin
	
		
			
		if(temp[31]==1)begin
		error=~temp+32'b1;


		end
		else begin
			error=temp;

		end
				
		$display("%d",i);
		$fwrite(fp_w,"%h\n",error);
		//$fwrite(gold,"%h\n",single_result);
end



always #(`PERIOD/2) CLK=~CLK;
			

			
always@(posedge CLK) begin
	single_y<=input1_sample[i];
	single_z<=input2_sample[i];
	single_x<=input3_sample[i];
	output_sample<=golden[i];
	i<=i+1;
	temp<=(output_sample-single_result);
	


end
	

initial begin
	CLK=1'b0;
	i=0;
	//$monitor("input_x=%b",input_x);
	fp_w=$fopen("result.dat","w");
	gold=$fopen("test.dat","w");
	
	/*
	for (i=0;i<=sample_sum;i=i+1)begin
		single_x=input_sample[i];
		gold=golden[i];
		#(`PERIOD)
		output_sample=golden[i];
	
		//$fwrite(fp_w,"%h\n",single_y);
		
	
		
		$fwrite(fp_w,"%h\n",temp);
		
		$display("%d",i);
		/*
		if(temp>=32'd2)
		$fwrite(fp_w,"%d %d %h \n",temp,i,single_x);
		
		

	end*/
	
	#((`PERIOD)*(sample_sum+1))
	$fclose(fp_w);
	$fclose(gold);
	$finish;
end

`ifdef fsdb
initial begin
	$fsdbDumpfile("sfu.fsdb");
	$fsdbDumpvars(0,"+mda");
end
`endif


//ifdef vcd
//nitial begin
//	$dumpfile("sfu.vcd");
//	$dumpvars;
//nd
//endif


`ifdef syn
initial begin
	$sdf_annotate("SFU_v1_syn40.sdf",SFU1);
end
`elsif test
initial begin
	$sdf_annotate("SFU_test_syn40.sdf",SFU1);
end
`endif


endmodule
rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+rcp_fp32+test
sort result.dat | uniq -c >./result/rcp_fp32.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+rcp_fp16+test
sort result.dat | uniq -c >./result/rcp_fp16.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+sqrt_fp32+test
sort result.dat | uniq -c >./result/sqrt_fp32.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+sqrt_fp16+test
sort result.dat | uniq -c >./result/sqrt_fp16.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+rsqrt_fp32+test
sort result.dat | uniq -c >./result/rsqrt_fp32.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+rsqrt_fp16+test
sort result.dat | uniq -c >./result/rsqrt_fp16.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+pow2_fp32+test
sort result.dat | uniq -c >./result/pow2_fp32.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+pow2_fp16+test
sort result.dat | uniq -c >./result/pow2_fp16.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+log2_fp32+test
sort result.dat | uniq -c >./result/log2_fp32.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+log2_fp16+test
sort result.dat | uniq -c >./result/log2_fp16.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+sin_fp32+test
sort result.dat | uniq -c >./result/sin_fp32.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+sin_fp16+test
sort result.dat | uniq -c >./result/sin_fp16.txt


rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+fma_fp32+test
sort result.dat | uniq -c >./result/fma_fp32.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+fma_fp16+test
sort result.dat | uniq -c >./result/fma_fp16.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+sigmoid_fp32+test
sort result.dat | uniq -c >./result/sigmoid_fp32.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+sigmoid_fp16+test
sort result.dat | uniq -c >./result/sigmoid_fp16.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+tanh_fp32+test
sort result.dat | uniq -c >./result/tanh_fp32.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+tanh_fp16+test
sort result.dat | uniq -c >./result/tanh_fp16.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+relu_fp32+test
sort result.dat | uniq -c >./result/relu_fp32.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+relu_fp16+test
sort result.dat | uniq -c >./result/relu_fp16.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+relu6_fp32+test
sort result.dat | uniq -c >./result/relu6_fp32.txt

rm -fr INCA_libs
ncverilog SFU_tb.sv +access+r +sv +define+relu6_fp16+test
sort result.dat | uniq -c >./result/relu6_fp16.txt




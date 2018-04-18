set_min_lib sc9_cln40g_base_rvt_ss_typical_max_0p81v_125c.db       -min sc9_cln40g_base_rvt_ff_typical_min_0p99v_m40c.db       ; #for core lib

#multi core 1~16
set_host_options -max_core 4

#Enable Power-analysis Mode
set power_enable_analysis TRUE
set power_analysis_mode time_based


read_verilog ./SFU_test_syn40.v

current_design SFU_top
link


read_sdc -version Latest ./SFU_test_syn40.sdc
read_sdf -load_delay net ./SFU_test_syn40.sdf 
#set_propagated_clock [all_clocks ]
read_vcd -strip_path /SFU_tb/SFU1 ./waveform/sin_fp16.vcd

 

#set_operating_conditions -max slow -max_library slow -min fast -min_library fast
set_power_analysis_options -waveform_interval 0.01 -waveform_format fsdb -waveform_output ./waveform/sin_fp16_syn40_power

check_power
update_power
get_design
report_power
report_power -verbose 	
report_power -hierarchy > ./power/sin/SIN_FP16_h.txt
report_power  	> ./power/sin/SIN_FP16_all.txt
exit

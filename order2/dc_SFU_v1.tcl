# Set Parallelism
# ----------------TSMC/Artisan .04um .synopsys_dc.setup----------------------
set company "NCKU VCSDL"
set designer "SWE"
set search_path "/cad/Cell_Library/CBDK_TSMC40_Arm_f2.0/CIC/SynopsysDC/db/sc9_base_rvt $search_path"
set target_library "sc9_cln40g_base_rvt_ff_typical_min_0p99v_m40c.db sc9_cln40g_base_rvt_ss_typical_max_0p81v_125c.db \
		    LUT1_a_nldm_tt_0p90v_25c_syn.db LUT1_c0_nldm_tt_0p90v_25c_syn.db LUT1_c1_nldm_tt_0p90v_25c_syn.db LUT1_c2_nldm_tt_0p90v_25c_syn.db \
			LUT2_a_nldm_tt_0p90v_25c_syn.db LUT2_c0_nldm_tt_0p90v_25c_syn.db LUT2_c1_nldm_tt_0p90v_25c_syn.db LUT2_c2_nldm_tt_0p90v_25c_syn.db"
set link_library "{*} $target_library dw_foundation.sldb"
set symbol_library "tsmc40.sdb"
set synthetic_library "dw_foundation.sldb"

set hdlin_translate_off_skip_text "TRUE"
set edifout_netlist_only "TRUE"
set verilogout_no_tri true
set sh_enable_line_editing true



# ----------------TSMC/Artisan .09um .synopsys_dc.setup----------------------

#set company "NCKU VCSDL"
#set designer "SWE"
#set search_path "/cad/Cell_Library/CBDK_TSMC90G_Arm_v1.1/CIC/SynopsysDC/db/ $search_path"
#set link_library "{*} slow.db fast.db dw_foundation.sldb"
#set target_library "slow.db fast.db"
#set symbol_library "tsmc09.sdb"
#set synthetic_library "dw_foundation.sldb"
#
#set hdlin_translate_off_skip_text "TRUE"
#set edifout_netlist_only "TRUE"
#set verilogout_no_tri true
#set sh_enable_line_editing true



# -Import Design           #

define_design_lib LAB -path ./LAB
read_file -format verilog {./calculation_circuit.v}
read_file -format sverilog {./AG_multi_v1.sv}

read_file -format verilog {./LUT2_wrap.v}
read_file -format verilog {./LUT1_wrap.v}
read_file -format verilog {./Approx_v1.v}

read_file -format verilog {./LOD.v}
read_file -format verilog {./pre_processing.v}
read_file -format verilog {./post_processing.v}
read_file -format verilog {./SFU_v1.v}


analyze -library LAB -format verilog SFU_v1.v
elaborate SFU_v1 -architecture verilog -library LAB

#  Setting Design Environment   #
current_design SFU_v1
set_operating_conditions -min_library sc9_cln40g_base_rvt_ff_typical_min_0p99v_m40c -min ff_typical_min_0p99v_m40c  -max_library sc9_cln40g_base_rvt_ss_typical_max_0p81v_125c -max ss_typical_max_0p81v_125c
set_wire_load_model -name Small -library sc9_cln40g_base_rvt_ss_typical_max_0p81v_125c
link
uniquify

#       DC Constraints          #

set_max_delay 1.4 -from [all_inputs] -to [all_outputs]
set_min_delay 0.1 -from [all_inputs] -to [all_outputs]

#create_clock -name "CLK" -period 2.0 -waveform {0 5.0} [get_ports CLK]
#set_clock_latency 1 [get_clocks CLK]#
#set_clock_latency -source 1 [get_clocks CLK]#
#set_clock_uncertainty 0.3 [get_clocks CLK]#
set_dont_touch_network [get_clock CLK]
set_fix_hold [get_clocks CLK]
set_ideal_network [get_ports CLK]


#  Synthesis all design         #

#set dw_prefer_mc_inside true
set_fix_multiple_port_nets -feedthroughs
set_fix_multiple_port_nets -all -buffer_constants
check_design
#compile -map_effort medium -boundary_optimization
compile -exact_map
#       Change_Names            #

#remove_unconnected_ports -blast_buses [get_cells -hierarchical *]
change_names -hierarchy -rule verilog
define_name_rules name_rule -allowed "a-z A-Z 0-9 _" -max_length 255 -type cell
define_name_rules name_rule -allowed "a-z A-Z 0-9 _[]" -max_length 255 -type net
define_name_rules name_rule -map {{"\\*cell\\*" "cell"}}
define_name_rules name_rule -case_insensitive
change_names -hierarchy -rules name_rule


#       Output Files            #

write -hierarchy -format ddc -output SFU_v1_syn40.ddc
write -format verilog -hierarchy -output SFU_v1_syn40.v
write_sdf -version 2.0 -context verilog SFU_v1_syn40.sdf 
write_sdc SFU_v1_syn40.sdc

uplevel #0 { report_area }
uplevel #0 { report_timing -path full -delay max -nworst 1 -max_paths 1 -significant_digits 5 -sort_by group }


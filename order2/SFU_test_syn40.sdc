###################################################################

# Created by write_sdc on Fri Apr  6 12:11:05 2018

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max ss_typical_max_0p81v_125c -max_library           \
sc9_cln40g_base_rvt_ss_typical_max_0p81v_125c\
                         -min ff_typical_min_0p99v_m40c -min_library           \
sc9_cln40g_base_rvt_ff_typical_min_0p99v_m40c
set_wire_load_model -name Small -library                                       \
sc9_cln40g_base_rvt_ss_typical_max_0p81v_125c
set_max_delay 2.5  -from [list [get_ports precision] [get_ports {opcode[3]}] [get_ports          \
{opcode[2]}] [get_ports {opcode[1]}] [get_ports {opcode[0]}] [get_ports        \
{single_x[31]}] [get_ports {single_x[30]}] [get_ports {single_x[29]}]          \
[get_ports {single_x[28]}] [get_ports {single_x[27]}] [get_ports               \
{single_x[26]}] [get_ports {single_x[25]}] [get_ports {single_x[24]}]          \
[get_ports {single_x[23]}] [get_ports {single_x[22]}] [get_ports               \
{single_x[21]}] [get_ports {single_x[20]}] [get_ports {single_x[19]}]          \
[get_ports {single_x[18]}] [get_ports {single_x[17]}] [get_ports               \
{single_x[16]}] [get_ports {single_x[15]}] [get_ports {single_x[14]}]          \
[get_ports {single_x[13]}] [get_ports {single_x[12]}] [get_ports               \
{single_x[11]}] [get_ports {single_x[10]}] [get_ports {single_x[9]}]           \
[get_ports {single_x[8]}] [get_ports {single_x[7]}] [get_ports {single_x[6]}]  \
[get_ports {single_x[5]}] [get_ports {single_x[4]}] [get_ports {single_x[3]}]  \
[get_ports {single_x[2]}] [get_ports {single_x[1]}] [get_ports {single_x[0]}]  \
[get_ports {single_y[31]}] [get_ports {single_y[30]}] [get_ports               \
{single_y[29]}] [get_ports {single_y[28]}] [get_ports {single_y[27]}]          \
[get_ports {single_y[26]}] [get_ports {single_y[25]}] [get_ports               \
{single_y[24]}] [get_ports {single_y[23]}] [get_ports {single_y[22]}]          \
[get_ports {single_y[21]}] [get_ports {single_y[20]}] [get_ports               \
{single_y[19]}] [get_ports {single_y[18]}] [get_ports {single_y[17]}]          \
[get_ports {single_y[16]}] [get_ports {single_y[15]}] [get_ports               \
{single_y[14]}] [get_ports {single_y[13]}] [get_ports {single_y[12]}]          \
[get_ports {single_y[11]}] [get_ports {single_y[10]}] [get_ports               \
{single_y[9]}] [get_ports {single_y[8]}] [get_ports {single_y[7]}] [get_ports  \
{single_y[6]}] [get_ports {single_y[5]}] [get_ports {single_y[4]}] [get_ports  \
{single_y[3]}] [get_ports {single_y[2]}] [get_ports {single_y[1]}] [get_ports  \
{single_y[0]}] [get_ports {single_z[31]}] [get_ports {single_z[30]}]           \
[get_ports {single_z[29]}] [get_ports {single_z[28]}] [get_ports               \
{single_z[27]}] [get_ports {single_z[26]}] [get_ports {single_z[25]}]          \
[get_ports {single_z[24]}] [get_ports {single_z[23]}] [get_ports               \
{single_z[22]}] [get_ports {single_z[21]}] [get_ports {single_z[20]}]          \
[get_ports {single_z[19]}] [get_ports {single_z[18]}] [get_ports               \
{single_z[17]}] [get_ports {single_z[16]}] [get_ports {single_z[15]}]          \
[get_ports {single_z[14]}] [get_ports {single_z[13]}] [get_ports               \
{single_z[12]}] [get_ports {single_z[11]}] [get_ports {single_z[10]}]          \
[get_ports {single_z[9]}] [get_ports {single_z[8]}] [get_ports {single_z[7]}]  \
[get_ports {single_z[6]}] [get_ports {single_z[5]}] [get_ports {single_z[4]}]  \
[get_ports {single_z[3]}] [get_ports {single_z[2]}] [get_ports {single_z[1]}]  \
[get_ports {single_z[0]}]]  -to [list [get_ports {single_result[31]}] [get_ports {single_result[30]}]     \
[get_ports {single_result[29]}] [get_ports {single_result[28]}] [get_ports     \
{single_result[27]}] [get_ports {single_result[26]}] [get_ports                \
{single_result[25]}] [get_ports {single_result[24]}] [get_ports                \
{single_result[23]}] [get_ports {single_result[22]}] [get_ports                \
{single_result[21]}] [get_ports {single_result[20]}] [get_ports                \
{single_result[19]}] [get_ports {single_result[18]}] [get_ports                \
{single_result[17]}] [get_ports {single_result[16]}] [get_ports                \
{single_result[15]}] [get_ports {single_result[14]}] [get_ports                \
{single_result[13]}] [get_ports {single_result[12]}] [get_ports                \
{single_result[11]}] [get_ports {single_result[10]}] [get_ports                \
{single_result[9]}] [get_ports {single_result[8]}] [get_ports                  \
{single_result[7]}] [get_ports {single_result[6]}] [get_ports                  \
{single_result[5]}] [get_ports {single_result[4]}] [get_ports                  \
{single_result[3]}] [get_ports {single_result[2]}] [get_ports                  \
{single_result[1]}] [get_ports {single_result[0]}]]
set_min_delay 0.1  -from [list [get_ports precision] [get_ports {opcode[3]}] [get_ports          \
{opcode[2]}] [get_ports {opcode[1]}] [get_ports {opcode[0]}] [get_ports        \
{single_x[31]}] [get_ports {single_x[30]}] [get_ports {single_x[29]}]          \
[get_ports {single_x[28]}] [get_ports {single_x[27]}] [get_ports               \
{single_x[26]}] [get_ports {single_x[25]}] [get_ports {single_x[24]}]          \
[get_ports {single_x[23]}] [get_ports {single_x[22]}] [get_ports               \
{single_x[21]}] [get_ports {single_x[20]}] [get_ports {single_x[19]}]          \
[get_ports {single_x[18]}] [get_ports {single_x[17]}] [get_ports               \
{single_x[16]}] [get_ports {single_x[15]}] [get_ports {single_x[14]}]          \
[get_ports {single_x[13]}] [get_ports {single_x[12]}] [get_ports               \
{single_x[11]}] [get_ports {single_x[10]}] [get_ports {single_x[9]}]           \
[get_ports {single_x[8]}] [get_ports {single_x[7]}] [get_ports {single_x[6]}]  \
[get_ports {single_x[5]}] [get_ports {single_x[4]}] [get_ports {single_x[3]}]  \
[get_ports {single_x[2]}] [get_ports {single_x[1]}] [get_ports {single_x[0]}]  \
[get_ports {single_y[31]}] [get_ports {single_y[30]}] [get_ports               \
{single_y[29]}] [get_ports {single_y[28]}] [get_ports {single_y[27]}]          \
[get_ports {single_y[26]}] [get_ports {single_y[25]}] [get_ports               \
{single_y[24]}] [get_ports {single_y[23]}] [get_ports {single_y[22]}]          \
[get_ports {single_y[21]}] [get_ports {single_y[20]}] [get_ports               \
{single_y[19]}] [get_ports {single_y[18]}] [get_ports {single_y[17]}]          \
[get_ports {single_y[16]}] [get_ports {single_y[15]}] [get_ports               \
{single_y[14]}] [get_ports {single_y[13]}] [get_ports {single_y[12]}]          \
[get_ports {single_y[11]}] [get_ports {single_y[10]}] [get_ports               \
{single_y[9]}] [get_ports {single_y[8]}] [get_ports {single_y[7]}] [get_ports  \
{single_y[6]}] [get_ports {single_y[5]}] [get_ports {single_y[4]}] [get_ports  \
{single_y[3]}] [get_ports {single_y[2]}] [get_ports {single_y[1]}] [get_ports  \
{single_y[0]}] [get_ports {single_z[31]}] [get_ports {single_z[30]}]           \
[get_ports {single_z[29]}] [get_ports {single_z[28]}] [get_ports               \
{single_z[27]}] [get_ports {single_z[26]}] [get_ports {single_z[25]}]          \
[get_ports {single_z[24]}] [get_ports {single_z[23]}] [get_ports               \
{single_z[22]}] [get_ports {single_z[21]}] [get_ports {single_z[20]}]          \
[get_ports {single_z[19]}] [get_ports {single_z[18]}] [get_ports               \
{single_z[17]}] [get_ports {single_z[16]}] [get_ports {single_z[15]}]          \
[get_ports {single_z[14]}] [get_ports {single_z[13]}] [get_ports               \
{single_z[12]}] [get_ports {single_z[11]}] [get_ports {single_z[10]}]          \
[get_ports {single_z[9]}] [get_ports {single_z[8]}] [get_ports {single_z[7]}]  \
[get_ports {single_z[6]}] [get_ports {single_z[5]}] [get_ports {single_z[4]}]  \
[get_ports {single_z[3]}] [get_ports {single_z[2]}] [get_ports {single_z[1]}]  \
[get_ports {single_z[0]}]]  -to [list [get_ports {single_result[31]}] [get_ports {single_result[30]}]     \
[get_ports {single_result[29]}] [get_ports {single_result[28]}] [get_ports     \
{single_result[27]}] [get_ports {single_result[26]}] [get_ports                \
{single_result[25]}] [get_ports {single_result[24]}] [get_ports                \
{single_result[23]}] [get_ports {single_result[22]}] [get_ports                \
{single_result[21]}] [get_ports {single_result[20]}] [get_ports                \
{single_result[19]}] [get_ports {single_result[18]}] [get_ports                \
{single_result[17]}] [get_ports {single_result[16]}] [get_ports                \
{single_result[15]}] [get_ports {single_result[14]}] [get_ports                \
{single_result[13]}] [get_ports {single_result[12]}] [get_ports                \
{single_result[11]}] [get_ports {single_result[10]}] [get_ports                \
{single_result[9]}] [get_ports {single_result[8]}] [get_ports                  \
{single_result[7]}] [get_ports {single_result[6]}] [get_ports                  \
{single_result[5]}] [get_ports {single_result[4]}] [get_ports                  \
{single_result[3]}] [get_ports {single_result[2]}] [get_ports                  \
{single_result[1]}] [get_ports {single_result[0]}]]

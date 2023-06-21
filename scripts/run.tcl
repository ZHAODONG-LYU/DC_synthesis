# it is a dc script templete 
# some basic command
#################################
# script for run_dc for module submoudleY in moduleX
# Define Variable
#################################
set clock_name "Xclk"
set clock_period 40
set RTL_PATH "../RTL_codes"
set REPORT_PATH "../DC/report"
set PreSim_PATH "../PreSim/netlist"
set Design submoudleY
set_svf ${Design}.svf
#################################
# Read Design
#################################
saif_map -start
analyze -format verilog ${RTL_PATH}/***.v
analyze -format verilog ${RTL_PATH}/***.v
elaborate $Design
#################################
# the command is break the combinational loop of all the mux out, it seemed all of them end with 'mux?1_buf_???/X', so get_pins is to get all the muxes' output
set_disable_timing [get_pins -hierarchical **1_buf_*/X*] # it is a important command for some cases
set current_design DSP
source submpoudleY.con
#################################
# Saving Designs
#################################
#check_design
write -format ddc -hier -o $PreSim_PATH/${Design}_pre_dc.ddc
compile_ultra -incremental -timing_high_effort_script
compile -map_effort high  -ungroup_all -boundary_optimization -auto_ungroup area -exact_map
#################################
# these are some command for add buffer to specificed size mux's output
#set net [get_nets O]
# insert buffer, get_buffers
#insert_buffer  $net tcb018gbwp7ttc_ccs/DEL015BWP7T 
#################################
# check_design
write -format ddc -hierarchy -output $PreSim_PATH/${Design}_mapped.ddc
write -format verilog -hier -o $PreSim_PATH/${Design}_dc.v
write_sdf $PreSim_PATH/${Design}_dc.sdf
write_sdc $PreSim_PATH/${Design}_dc.sdc # it will added into innovus
# get report file
redirect -tee -file ${REPORT_PATH}/report_timing.txt {report_timing}
redirect -tee -file ${REPORT_PATH}/report_power.txt {report_power}
redirect -tee -file ${REPORT_PATH}/report_area.txt {report_area}
redirect -tee -file ${REPORT_PATH}/report_qor.txt {report_qor}
# gui_start


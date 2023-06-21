# it is a opt template script
# 
################################################################### 
##################################################################
current_design submoudleY
##################################################################
# Design Rule Constrains
##################################################################
set_max_fanout 				10000 [current_design]
set_max_transition 			1 [current_design]
# Design Environments
set auto_wire_load_selection 		true
set_wire_load_mode enclosed
##################################################################
# Set Optimizations Constraint
##################################################################
# clock 
set_max_delay 				-from [all_inputs] -to [all_outputs] 5
#set_min_delay 				-from [all_inputs] -to [all_outputs] 3
set_max_area 				20000 # no strict constrain
create_clock -name $clock_name -period $clock_period -wave {0 20} [get_ports $clock_name] 
set_clock_uncertainty -setup 		0.05 [get_ports $clock_name] 
set_clock_uncertainty -hold 		0.05 [get_ports $clock_name] 
set_dont_touch_network 			[get_ports $clock_name]
set_clock_latency 			0.2 [get_ports $clock_name]
# Input path
set All_input [remove_from_collection [all_inputs] [get_ports $clock_name]]
set_input_delay -max 			0.2 -clock $clock_name $All_input
set_input_delay -min 			0.2 -clock $clock_name $All_input
# Output path
set_output_delay -max 			0.2 -clock $clock_name [all_outputs]
set_output_delay -min 			0.2 -clock $clock_name [all_outputs]
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]
set compile_advanced_fix_multiple_port_nets true
set_app_var verilogout_no_tri 		true

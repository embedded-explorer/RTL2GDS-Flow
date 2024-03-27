# ####################################################################

#  Created by Genus(TM) Synthesis Solution 20.11-s111_1 on Wed Mar 27 19:48:41 IST 2024

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design rca

create_clock -name "clock" -period 5.0 -waveform {0.0 2.5} [get_ports clk_i]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports {a_i[3]}]
set_input_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports {a_i[2]}]
set_input_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports {a_i[1]}]
set_input_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports {a_i[0]}]
set_input_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports {b_i[3]}]
set_input_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports {b_i[2]}]
set_input_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports {b_i[1]}]
set_input_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports {b_i[0]}]
set_input_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports c_i]
set_output_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports {s_o[3]}]
set_output_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports {s_o[2]}]
set_output_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports {s_o[1]}]
set_output_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports {s_o[0]}]
set_output_delay -clock [get_clocks clock] -add_delay -max 2.0 [get_ports c_o]
set_wire_load_mode "enclosed"

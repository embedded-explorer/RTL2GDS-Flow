# Clock Period 5ns
create_clock -name clock -period 5 [get_ports "clk_i"]

# Set Input Delay 2ns
set_input_delay -max 2 [get_ports "a_i"] -clock [get_clocks "clock"]
set_input_delay -max 2 [get_ports "b_i"] -clock [get_clocks "clock"]
set_input_delay -max 2 [get_ports "c_i"] -clock [get_clocks "clock"]

# Set Output Delay 2ns
set_output_delay -max 2 [get_ports "s_o"] -clock [get_clocks "clock"]
set_output_delay -max 2 [get_ports "c_o"] -clock [get_clocks "clock"]

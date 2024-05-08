current_design openMSP430
set_units -time 1us
create_clock -name dco_clk -period 10 -waveform {0 5} [get_ports "dco_clk"]
set_clock_transition -rise 0.1 [get_clocks "dco_clk"]
set_clock_transition -fall 0.1 [get_clocks "dco_clk"]
set_clock_uncertainty 0.01 [get_ports "dco_clk"]
create_clock -name lfxt_clk -period 31.25 -waveform {0 15.625} [get_ports "lfxt_clk"]
set_clock_transition -rise 0.1 [get_clocks "lfxt_clk"]
set_clock_transition -fall 0.1 [get_clocks "lfxt_clk"]
set_clock_uncertainty 0.01 [get_ports "lfxt_clk"]
set_clock_groups -physically_exclusive -group dco_clk -group lfxt_clk
set_input_delay -max 2.0 [get_ports [all_inputs]] -clock [get_clocks "lfxt_clk"]
set_output_delay -max 3.0 [get_ports [all_outputs]] -clock [get_clocks "lfxt_clk"]

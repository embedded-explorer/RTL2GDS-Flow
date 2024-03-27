##############################################################################
# Genus Stylus CUI Synthesis Script
# genus -f run_syn.tcl
##############################################################################

# Set search path for libraries
set_db init_lib_search_path ../LIB

# Set search path for HDL
set_db init_hdl_search_path ../RTL

# Read standard cell library
read_libs slow_vdd1v0_basicCells.lib

# Read RTL code
read_hdl -sv full_adder.sv d_ff.sv rca.sv

# Elaborate Design
elaborate

# Read Constraints
read_sdc ../SDC/constraints.sdc

# DFT Setup
# Set DFT Scan FF Style
set_db dft_scan_style muxed_scan
# Add Prefix to DFT logic inserted
set_db dft_prefix dft_
# Define the test signals
define_shift_enable -name SE -active high -create_port SE
# Check DFT rules
check_dft_rules

# Perform Synthesis
# set_db syn_generic_effort medium
syn_generic
# set_db syn_map_effort medium
syn_map
# set_db syn_opt_effort medium
syn_opt

# Run DFT
# Check DFT rules
check_dft_rules
# Specify number of scan chains
set_db design:rca .dft_min_number_of_scan_chains 1
# Specify scan-in and scan-out ports
define_scan_chain -name top_chain -sdi scan_in -sdo scan_out -create_ports  
# Connect scan chains
connect_scan_chains -auto_create_chains
# Run icremental synthesis
syn_opt -incr
# View DFT chains
report_scan_chains
# Run ATPG analysis and vector generation
write_dft_atpg -library ../LIB_VERILOG/slow_vdd1v0_basicCells.v

# Generate timing report
report_timing > reports/report_timing.rpt

# Generate power report
report_power  > reports/report_power.rpt

# Generate area report
report_area   > reports/report_area.rpt

# Generate QOR report
report_qor    > reports/report_qor.rpt

# Write out synthesized netlist
write_hdl > outputs/rca_netlist.v

# Write out SDC
write_sdc > outputs/rca_sdc.sdc

# Write out SDF
write_sdf -timescale ns -nonegchecks -recrem split -edges check_edge -setuphold split > outputs/delays.sdf

#
write_scandef > outputs/rca.scandef

exit


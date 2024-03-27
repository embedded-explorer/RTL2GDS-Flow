set log file rca.log -replace
read library ../LIB_VERILOG/slow_vdd1v0_basicCells.v -verilog -both
read design ../RTL/rca.sv ../RTL/full_adder.sv ../RTL/d_ff.sv -systemverilog -golden
read design ../SYN/outputs/rca_netlist.v -verilog -revised
add pin constraints 0 SE  -revised
add ignored inputs scan_in -revised
add ignored outputs scan_out -revised
set system mode lec
add compared points -all
compare
report verification
exit

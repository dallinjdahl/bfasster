changequote(<, >)dnl
if { [ catch {
read_edif S_EDIF
set_property top_file S_EDIF [current_fileset]
link_design -part PART
ifdef(<XDC>,
	read_xdc XDC <
>)dnl
set_property design_mode GateLvl [current_fileset]
opt_design
place_design
route_design
write_checkpoint -force -file DCP
write_edif -force -file I_EDIF
write_verilog -force -file NETLIST
report_utilization -file UTIL
ifdef(<BIT>,
	write_bitstream -force BIT <
>)dnl
} ] } { exit 1 }
exit

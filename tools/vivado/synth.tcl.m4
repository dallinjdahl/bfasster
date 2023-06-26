changequote(<, >)dnl
if { [ catch {
set_part PART
ifdef(<V>,
	<read_verilog> V <
>)dnl
ifdef(<SV>,
	<read_verilog -sv> SV <
>)dnl
synth_design -top TOP
ifdef(<IO>,
	<place_ports
>)dnl
write_edif -force EDIF
write_checkpoint -force -file DCP
ifdef(<IO>,
	<report_io -force -file> IO <
>)dnl
} ] } { exit 1 }
exit

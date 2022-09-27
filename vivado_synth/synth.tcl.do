#!/bin/sh -e

configs="part synthargs"
pregens="src"

{
	for f in $configs; do
		echo config/$f
	done
	
	for f in $pregens; do
		echo pregen/$f
	done

} | xargs redo-ifchange

for v in $configs; do
	read $v <config/$v
done

for v in $pregens; do
	read $v <pregen/$v
done

exec cat <<eof
if { [ catch {
set top [lindex \$argv 0]
catch {
	read_verilog [glob $src/\$top/*.v]
	read_verilog -sv [glob $src/\$top/*.sv]
	read_vhdl [glob $src/\$top/*.vhd]}
synth_design -top \$top -part $part $synthargs
place_ports
write_checkpoint -force [lindex \$argv 1]
set cookie [lindex \$argv 2]
}]} {{ exit 1 }}
exit
eof

#!/bin/sh -e

redo-ifchange config/part

read part <config/part

cat <<eof
if {[ catch {
set top [lindex \$argv 0]
read_edif \$top.edif
set_property design_mode GateLvl [current_fileset]
set_property edif_top_file \$top.edif [current_fileset]
link_design -part $part
read_xdc \$top.xdc
opt_design
place_design
route_design
write_checkpoint -force -file [lindex \$argv 1]
}]}
eof

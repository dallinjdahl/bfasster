#!/bin/sh -e

redo-ifchange verilog.tcl config/vivadoargs pregen/src $2.impl.dcp
read vivadoargs <config/vivadoargs
read src <pregen/src

exec vivado $vivadoargs -mode batch -source verilog.tcl -tclargs $2 $3 1>&2

#!/bin/sh -e

redo-ifchange edif.tcl pregen/cookie $2.synth.dcp config/vivadoargs

read cookie <pregen/cookie
read vivadoargs <config/vivadoargs
exec vivado $vivadoargs -mode batch -source edif.tcl -tclargs $2 $3 $cookie 1>&2
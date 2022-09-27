#!/bin/sh -e

redo-ifchange bitstream.tcl config/vivadoargs pregen/src $2.impl.dcp
read vivadoargs <config/vivadoargs
read src <pregen/src

exec vivado $vivadoargs -mode batch -source bitstream.tcl -tclargs $2 $3 1>&2

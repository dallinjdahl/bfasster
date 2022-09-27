#!/bin/sh -e

redo-ifchange impl.tcl config/vivadoargs pregen/src
read vivadoargs <config/vivadoargs
read src <pregen/src
top=`basename $2`

exec vivado $vivadoargs -mode batch -source impl.tcl -tclargs $2 $3 1>&2

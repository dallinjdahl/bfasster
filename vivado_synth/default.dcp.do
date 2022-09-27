#!/bin/sh -e
redo-ifchange pregen/cookie synth.tcl config/vivadoargs pregen/src
read cookie <pregen/cookie
read vivadoargs <config/vivadoargs
read src <pregen/src
top=`basename $2`

find $src/$top -type f -name '*.v' -o -name '*.sv' -o -name '*.vhd' | xargs redo-ifchange

exec vivado $vivadoargs -mode batch -source synth.tcl -tclargs $2 $3 $cookie 1>&2

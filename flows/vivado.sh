#!/bin/sh

root=$(pwd)/..

design=$root/designs/add4
output=$design/out
top=add4
v=$design/add4.v
sv=

srcs=
part=xc7a100tcsg324-1


utils=$root/bin
vivado_library=$root/tools/vivado

[ -z $v ] || srcs=-DV=$v
[ -z $sv ] || srcs=$srcs -DSV=$sv
mkdir -p $output
cp $vivado_library/vivado.ninja $output/build.ninja
{
m4 -DPART=$part -DSRCS=$srcs -DTOP=$top -DUTILS=$utils -DBFASSTER_VIVADO=$vivado_library <$vivado_library/synth.ninja.m4
m4 -DPART=$part -DS_EDIF=viv_synth.edif -DTOP=$top -DUTILS=$utils -DBFASSTER_VIVADO=$vivado_library <$vivado_library/impl.ninja.m4
cat <<eof
rule configure
   command = cd $root/flows; ./vivado.sh
   generator = 1
build build.ninja: configure $vivado_library/synth.ninja.m4 $vivado_library/synth.ninja.m4 $root/flows/vivado.sh $vivado_library/vivado.ninja
eof
} >>$output/build.ninja

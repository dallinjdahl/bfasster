changequote(%<, >%)dnl
rule synth_tcl
   command = m4 -DPART=PART SRCS -DTOP=TOP -DEDIF=viv_synth.edif -DDCP=synth.dcp ifdef(%<OOC>%, , -DIO=io) <$in >$out

rule vivado_ioparse
   command = UTILS/vivado_ioparse <$in >$out
   description = vivado_ioparse <$in >$out

build synth.tcl: synth_tcl BFASSTER_VIVADO/synth.tcl.m4

build TOP.xdc: vivado_ioparse io

build viv_synth.edif synth.dcp io: vivado synth.tcl | ifdef(%<V>%, V) ifdef(%<SV>%, SV)

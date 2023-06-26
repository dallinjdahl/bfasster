changequote(%<, >%)dnl
rule impl_tcl
   command = m4 -DPART=PART -DS_EDIF=S_EDIF ifdef(%<OOC>%, , -DXDC=TOP.xdc) $
      -DI_EDIF=viv_impl.edif -DDCP=impl.dcp -DUTIL=util $
      ifdef(%<OOC>%, , -DBIT=TOP.bit) -DNETLIST=viv_impl.v <$in >$out

build impl.tcl: impl_tcl BFASSTER_VIVADO/impl.tcl.m4

build viv_impl.v viv_impl.edif impl.dcp TOP.bit util: vivado impl.tcl | S_EDIF TOP.xdc

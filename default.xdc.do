#!/usr/bin/env python
import re
import sys
import subprocess

def constraints(xdc, io):
    with open(io, "r") as fp:
        txt = fp.read()

    match = re.search("2. IO Assignments by Package Pin\n------(.*)$", txt, re.DOTALL)

    lines = match.group(1).splitlines()
    with open(xdc, "w") as fp:
        for line in lines:
            m = re.match("\|\s+([A-Z]+[0-9]+)\s+\|\s+(\S+)\s+\|", line)
            if m and m.group(2) != "|":
                fp.write("set_property -dict "\
                f"{{ PACKAGE_PIN {m.group(1)} IOSTANDARD LVCMOS33 }} "\
                f"[get_ports {{ {m.group(2)} }}];\n" )

if __name__=="__main__":
    subprocess.call(["redo-ifchange", f"{sys.argv[2]}.io"], close_fds=False)
    constraints(sys.argv[3], f"{sys.argv[2]}.io")

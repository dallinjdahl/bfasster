#!/bin/sh -e
src=../config/src
if test -f $src; then
	redo-ifchange $src
	exec cat $src
fi
redo-ifcreate $src
echo "."

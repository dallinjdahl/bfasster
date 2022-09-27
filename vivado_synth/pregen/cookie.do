#!/bin/sh -e
redo-ifchange ../config/*
tr -cd 'a-z0-9' </dev/urandom | head -c 8
echo 

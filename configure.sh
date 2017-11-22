#!/usr/bin/env bash
PROGRAM="temp"

cat Makefile.in | sed "s/@PROGRAM@/${PROGRAM}/g" > Makefile

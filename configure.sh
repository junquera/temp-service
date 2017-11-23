#!/usr/bin/env bash
PROGRAM="temp"
# TODO Hacer esto con argumentos
SYSD=0

cat Makefile.in | sed "s/@PROGRAM@/${PROGRAM}/g" | sed "s/@SYSD@/${SYSD}/g" > Makefile

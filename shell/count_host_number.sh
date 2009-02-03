#!/bin/bash
for i in `cat $1` ;do 
	ipcalc $i
	done|awk '{n+=$2}END{print n}'

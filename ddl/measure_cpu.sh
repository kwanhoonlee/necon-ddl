#!/bin/bash

for (( i=0; i<60; i++));
do

	for (( j=0; j<$1; j++));
	do
		docker stats --no-stream --format "{{.CPUPerc}}" p$j >> $j.txt &
	done;
	sleep 1s;
done;

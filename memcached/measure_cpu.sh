#!/bin/bash
TIME=60
for (( i=0; i<$TIME; i++));
do

	for (( j=0; j<$1; j++));
	do
		docker stats --no-stream --format "{{.CPUPerc}}" m$j >> ./results/$j.txt &
	done;
	sleep 1s;
done

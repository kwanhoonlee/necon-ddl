#!/bin/bash
NUM_NODES=$1
NUM_CPUS=4
IPADDRESS=172.23.0.
BRIDGE="br-n-ddl"
PORT=5012
BENCHMARK_DIR_PATH="/home/oslab2/Documents/github.com/benchmarks/:/mnt/benchmarks/"

for (( i=0; i<$NUM_NODES; i=i+1 ))
do
        docker run --shm-size="8g" --name w$i --network $BRIDGE \
        -v $BENCHMARK_DIR_PATH -p ${PORT}/tcp -d tensorflow/tensorflow:1.12.0-rc2 \

	docker update --cpus=$NUM_CPUS w$i
done



#!/bin/bash

NUM_CPUS=2
IPADDRESS=172.24.0.
BRIDGE="br-n-ddl"
PORT=5012
BENCHMARK_DIR_PATH="/home/test/Documents/github.com/benchmarks/:/mnt/benchmarks/"

docker run --shm-size="8g" --name p0 --network $BRIDGE \
-v $BENCHMARK_DIR_PATH -p ${PORT}/tcp -d tensorflow/tensorflow:1.12.0-rc2 \
docker update --cpus=$NUM_CPUS w$i




#!/bin/bash
NUM_NODES=$1
NUM_CPUS=4

PS_IPADDR=172.24.0.
IPADDRESS=172.23.0.
ADDRESS=""
BRIDGE="br-n-ddl"
PORT=5012
BENCHMARK_DIR_PATH="/home/oslab2/Documents/github.com/benchmarks/:/mnt/benchmarks/"

THREADS=4
MODEL=$2

for i in $(seq 2 $(($NUM_NODES+1)));
do
	ADDRESS+="${IPADDRESS}${i}:${PORT},"
done

ADDRESS=${ADDRESS::-1}
echo $ADDRESS

for (( i=0; i<$NUM_NODES; i=i+1 ))
do
        docker run --shm-size="8g" --name w$i --network $BRIDGE \
        -v $BENCHMARK_DIR_PATH -p ${PORT}/tcp -d tensorflow/tensorflow:1.12.0-rc2 \

	docker update --cpus=$NUM_CPUS w$i
done

for (( i=0; i<$NUM_NODES; i=i+1 ))
do
	echo $i
	sleep 1s
	docker exec -d w$i python ../mnt/benchmarks/scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
	--batch_size=64 --model=${MODEL} --variable_update=parameter_server --data_format=NHWC \
	--job_name=worker --ps_hosts=${PS_IPADDR}2:${PORT} \
	--worker_hosts=${ADDRESS} --num_intra_threads=${THREADS} --num_inter_threads=${THREADS} \
	--data_name=imagenet --cross_replica_sync=true --task_index=${i}

done



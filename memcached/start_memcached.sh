#!/bin/bash

NUM_NODE=$1
MEMORY_SIZE=$2
BRIDGE=br-n-memcached
THREADS=4

for (( i=0; i<$1; i=i+1 ))
do
   
   docker run --name m$i --network $BRIDGE -p 11211/udp -d memcached:1.4 memcached -m $MEMORY_SIZE -U 11211 -t $THREADS
   docker inspect -f '{{.State.Pid}}' m$i
   #docker update --cpus=2 m$i
done

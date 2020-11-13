#!/bin/bash

NUM_NODE=$1
MEMORY_SIZE=4096
BRIDGE=br-n-memcached
THREADS=2
QUOTA=-1
for (( i=0; i<$NUM_NODE; i=i+1 ))
do
   
   docker run --name m$i --network $BRIDGE -p 11211/udp -d memcached:1.4 memcached -m $MEMORY_SIZE -U 11211 -t $THREADS
   docker inspect -f '{{.State.Pid}}' m$i
#   docker update --cpus=$THREADS m$i
   docker update --cpu-quota=$QUOTA m$i
done

#docker update --cpuset-cpus=6-9 m0


#!/bin/bash

CONTAINER_NAMES=()
CONTAINER_IDS=()
CONTAINER_NETINTERFACES=()

for container in $(docker ps -a --format "{{.Names}}"); do
	CONTAINER_NAMES+=($container)
done

for container in $(docker ps -q); do
	iflink=`docker exec -it $container bash -c 'cat /sys/class/net/eth0/iflink'`
	iflink=`echo $iflink|tr -d '\r'`
	veth=`grep -l $iflink /sys/class/net/veth*/ifindex`
	veth=`echo $veth|sed -e 's;^.*net/\(.*\)/ifindex$;\1;'`
	CONTAINER_INTERFACES+=($veth)
	CONTAINER_IDS+=($container)
done

PATTERN='orderer*'

for container in ${CONTAINER_NAMES[@]}; do
	if [[ "$container" == $PATTERN ]]; then
		echo $container
	fi
done

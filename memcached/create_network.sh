#!/bin/bash

IPADDRESS=172.30.0
BRIDGE=br-n-memcached
docker network create --gateway $IPADDRESS.1 --subnet $IPADDRESS.0/16 $BRIDGE

#!/bin/bash

IPADDRESS=172.23.0
docker network create --gateway $IPADDRESS.1 --subnet $IPADDRESS.0/16 br-n-ddl


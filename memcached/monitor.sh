#!/bin/bash

./measure_cpu.sh 2 &
./monitoring_network.sh vethb3ea6ce &
./monitoring_network.sh vethe3fd344 &

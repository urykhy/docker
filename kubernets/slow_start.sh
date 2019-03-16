#!/bin/bash

docker-compose start etcd master
sleep 10
docker-compose start dns
sleep 3
docker-compose start node1 node2

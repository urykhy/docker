#!/bin/bash

docker-compose start etcd master
sleep 2
docker-compose start dns
docker-compose start node1 node2

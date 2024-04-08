#!/bin/bash

sed -i "s/%KAFKA_BROKER_ID%/${KAFKA_BROKER_ID:-1}/" /broker.properties
while true; do ./zookeeper-shell.sh zookeeper version && break; echo "wait until ZK started .."; sleep 2; done
while true; do ./zookeeper-shell.sh zookeeper ls /brokers/ids/${KAFKA_BROKER_ID} || break; echo "wait until ZK node expired .."; sleep 2; done
exec ./kafka-server-start.sh /broker.properties

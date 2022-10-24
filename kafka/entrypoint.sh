#!/bin/bash

sed -i "s/%KAFKA_BROKER_ID%/${KAFKA_BROKER_ID:-1}/" /broker.properties
exec ./kafka-server-start.sh /broker.properties
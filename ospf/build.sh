#!/bin/sh

docker stop ospf
docker rm ospf
docker build -t urykhy/ospf .

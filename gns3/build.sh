#!/bin/sh

docker stop gns3
docker rm gns3
docker build -t urykhy/gns3 .

#!/bin/bash
set -e

export NODE_NAME=`hostname`
flanneld -kube-api-url=http://master:8080 --kube-subnet-mgr &
sleep 4
. /var/run/flannel/subnet.env
export FLANNEL_SUBNET
export FLANNEL_MTU
exec /usr/bin/supervisord

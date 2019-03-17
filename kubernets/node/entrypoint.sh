#!/bin/bash
set -e

export NODE_NAME=`hostname`
flanneld -kube-api-url=http://master:8080 --kube-subnet-mgr &

for i in `seq 1 10`; do
    if [ -f /var/run/flannel/subnet.env ]; then
        break;
    else
        sleep 1
    fi
done

. /var/run/flannel/subnet.env
export FLANNEL_SUBNET
export FLANNEL_MTU
exec /usr/bin/supervisord
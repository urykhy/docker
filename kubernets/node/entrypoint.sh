#!/bin/bash
set -e

mkdir -p /mnt/m1 || true
mount none -t cgroup /mnt/m1
mount --make-private /sys/fs/cgroup/cgroup
mount --bind /mnt/m1 /sys/fs/cgroup/cgroup
umount /mnt/m1

export NODE_NAME=`hostname`

rpcbind
flanneld --etcd-endpoints=http://172.16.9.2:2379 &
#flanneld -kube-api-url=http://172.16.9.3:8080 --kube-subnet-mgr &

for i in `seq 1 10`; do
    if [ -f /var/run/flannel/subnet.env ]; then
        break;
    else
        sleep 1
    fi
done

rm /var/run/docker.pid || true

. /var/run/flannel/subnet.env
export FLANNEL_SUBNET
export FLANNEL_MTU
exec /usr/bin/supervisord

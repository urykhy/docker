#!/bin/bash

"$@" &
pid="$!"
trap 'kill $pid;' SIGTERM

sleep 1

if [ -n "$GLUSTER_OTHER" ];
then
    sleep 1
    for peer in $GLUSTER_OTHER; do
        echo "probe $peer"
        gluster peer probe $peer
    done
fi

if [ -n "$GLUSTER_INIT" -a ! -f /var/lib/glusterd/ready ];
then
    sleep 2
    gluster volume create gv0 replica 3 gs1:/var/lib/glusterd/brick1 gs2:/var/lib/glusterd/brick1 gs3:/var/lib/glusterd/brick1 force
    gluster volume start gv0
    touch /var/lib/glusterd/ready
fi

wait

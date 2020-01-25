#!/bin/bash

nmbd_pid=0
smbd_pid=0

trap clean_exit EXIT
function clean_exit
{
    echo "exiting ..."
    kill $nmbd_pid $smbd_pid
    wait $nmbd_pid $smbd_pid
    echo "ok ..."
    exit 0
}

/usr/sbin/smbd -F -S --no-process-group &
smbd_pid="$!"

/usr/sbin/nmbd -F -S --no-process-group &
nmbd_pid="$!"

while true; do
    wait
done

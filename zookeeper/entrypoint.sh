#!/bin/bash

if [[ ! -f "/data/data/myid" ]]; then
    mkdir -p /data/data
    mkdir -p /data/log
    echo "1" > "/data/data/myid"
fi

exec "$@"
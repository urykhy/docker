#!/bin/bash

DATA="/data"
mkdir -p $DATA/upload
mkdir -p $DATA/temp
mkdir -p $DATA/report
chmod 777 $DATA/upload
chmod 777 $DATA/temp

DONE=0
trap 'DONE=1; ' SIGTERM

while [ "$DONE" -eq "0" ]
do
    ls -la $DATA/upload/*.xml > /tmp/.current 2> /dev/null

    if ! [ -s /tmp/.current ]; then
        sleep 1
        continue
    fi

    if [ -f /tmp/.old ]; then
        cmp -s /tmp/.current /tmp/.old >/dev/null
        RC="$?"
        if [ "$RC" == "0" ]; then
            sleep 1
            continue
        fi
    fi

    allure generate -o $DATA/report $DATA/upload
    mv /tmp/.current /tmp/.old
done

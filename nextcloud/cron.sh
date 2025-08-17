#!/bin/bash

RUN="1"
trap 'echo Got signal; RUN=0; kill $(jobs -p);' TERM INT;

while [[ "$RUN" = "1" ]]; do
    date
    php cron.php
    sleep 600s &
    wait
done

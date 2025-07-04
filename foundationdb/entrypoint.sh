#!/bin/bash

ADDR=`hostname -I | xargs`
echo "* detected node ip $ADDR"
echo "foundationdb.conf"
mkdir /etc/foundationdb/

cat /tmp/foundationdb.conf.in | sed -e "s|%ADDR%|$ADDR|" | tee /etc/foundationdb/foundationdb.conf
echo "fdb.cluster"
cat /tmp/fdb.cluster.in | sed -e "s|%ADDR%|$ADDR|" | tee /etc/foundationdb/fdb.cluster

cat /etc/foundationdb/foundationdb.conf | grep 45 | sed -e 's/.*\(45..\).*/\1/' | while read a; do mkdir /var/fdb/data/$a /var/fdb/logs/$a || true; done

fdbmonitor

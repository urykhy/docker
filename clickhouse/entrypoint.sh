#!/bin/bash

HOST=`hostname -s`
sed -i "s/%HOST%/$HOST/; s/%SHARD%/$SHARD/" /etc/metrika.xml
sed -i "s/%HOST%/$HOST/; s/%SHARD%/$SHARD/" /etc/clickhouse-backup/config.yml

exec gosu clickhouse /usr/bin/clickhouse server --config=/etc/clickhouse-server/config.xml

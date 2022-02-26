#!/bin/bash

HOST=`hostname -s`
sed -i "s/%HOST%/$HOST/" /etc/metrika.xml
sed -i "s/%SHARD%/$SHARD/" /etc/metrika.xml

exec gosu clickhouse /usr/bin/clickhouse server --config=/etc/clickhouse-server/config.xml

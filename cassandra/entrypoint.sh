#!/bin/bash
set -e

MYHOST=`hostname`
MYIP=`getent ahosts $HOSTNAME | awk '{ print $1 }' | head -n 1`

sed -ie "s/listen_address: .*/listen_address: $MYIP/"        /etc/cassandra/cassandra.yaml

if [ -n "$CASSANDRA_SEED" ]; then
    sed -ie "s/seeds: \"127.0.0.1\"/seeds: \"$CASSANDRA_SEED\"/"  /etc/cassandra/cassandra.yaml
fi

echo "auto_bootstrap: false"                              >> /etc/cassandra/cassandra.yaml

exec "$@"

#!/bin/bash

mkdir -p     /data/tmp /data/sql
chmod 777    /data/tmp /data/sql
chown nobody /data/tmp /data/sql

if [ -z "$(ls -A /data/sql)" ]; then
    echo "Initialize ..."
    /opt/mysql/server-5.7/bin/mysqld --defaults-file=/etc/my.cnf -u nobody --initialize
fi
exec /opt/mysql/server-5.7/bin/mysqld --defaults-file=/etc/my.cnf -u nobody --skip-grant-tables

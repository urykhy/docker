#!/bin/bash

mkdir -p     /data/tmp /data/sql
chmod 777    /data/tmp /data/sql
chown mysql -R /data/tmp /data/sql

if [ -z "$(ls -A /data/sql)" ]; then
    echo "Initialize ..."
    mysqld --defaults-file=/etc/my.cnf -u mysql --initialize
fi
exec mysqld --defaults-file=/etc/my.cnf -u mysql

#!/bin/bash

mkdir bak
CRED="--user=root --password=root --host=mysql-slave"
BACKUP="--backup --slave-info --safe-slave-backup --parallel=4 --rsync $CRED"
PREPARE="--prepare --export --use-memory=128M"
./xtrabackup $BACKUP --datadir=/var/lib/mysql --target-dir=/data/bak --databases=test
./xtrabackup $PREPARE --target-dir=/data/bak

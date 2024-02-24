#!/bin/bash

exec docker run --rm -it -v `pwd`:/data --name "xtrabackup-`hostname`" --hostname "xtrabackup-`hostname`" --volumes-from mysql-slave urykhy/xtrabackup xtrabackup "$@"

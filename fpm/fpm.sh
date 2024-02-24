#!/bin/bash

exec docker run -u $UID --rm -it -v `pwd`:/data --name "fpm-`hostname`" --hostname "fpm-`hostname`" urykhy/fpm fpm "$@"

#!/bin/bash

mkdir /tmp/pip || true
exec docker run -u $UID --rm -it -v `pwd`:/data -v /tmp:/.cache -v /tmp:/tmp -e HOME=/tmp --name "fpm-`hostname`" --hostname "fpm-`hostname`" urykhy/fpm fpm "$@"

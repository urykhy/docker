#!/bin/bash

mkdir /tmp/pip || true
exec docker run -u $UID --rm -it -v `pwd`:/data -v /tmp:/.cache -e HOME=/tmp --name "fpm-`hostname`" --hostname "fpm-`hostname`" urykhy/fpm fpm "$@"

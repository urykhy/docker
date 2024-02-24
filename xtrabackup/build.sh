#!/bin/sh

docker build -t urykhy/xtrabackup . --build-arg APT_PROXY=$APT_PROXY

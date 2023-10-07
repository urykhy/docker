#!/bin/sh

docker build -t urykhy/zookeeper --build-arg APT_PROXY=${APT_PROXY} .

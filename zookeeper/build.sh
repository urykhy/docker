#!/bin/sh

docker build -t urykhy/zookeeper --build-arg APT_PROXY=http://elf.dark:8081 .
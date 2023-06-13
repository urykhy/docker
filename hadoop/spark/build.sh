#!/bin/sh

docker build -t urykhy/hadoop-spark --build-arg S_PROXY=http://elf.dark:8082 .

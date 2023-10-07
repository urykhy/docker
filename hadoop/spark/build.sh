#!/bin/sh

docker build -t urykhy/hadoop-spark --build-arg S_PROXY=${S_PROXY} .

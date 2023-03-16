#!/bin/bash

exec docker run --rm -it -v `pwd`:/data --name "allure-`hostname`" --hostname "allure-`hostname`" --entrypoint allure --workdir=/data urykhy/allure-engine "$@"

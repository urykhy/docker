#!/bin/sh

docker build -t urykhy/hadoop --build-arg WITH_KERBEROS=false --build-arg APT_PROXY=http://elf.dark:8081 --build-arg S_PROXY=http://elf.dark:8082 .

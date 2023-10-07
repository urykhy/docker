#!/bin/sh

docker build -t urykhy/hadoop --build-arg WITH_KERBEROS=false --build-arg APT_PROXY=${APT_PROXY} --build-arg S_PROXY=${S_PROXY} .

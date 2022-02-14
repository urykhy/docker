#!/bin/sh

docker build -t urykhy/hadoop --build-arg WITH_KERBEROS=true .

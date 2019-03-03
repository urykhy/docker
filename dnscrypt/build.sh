#!/bin/sh

docker stop dnscrypt
docker rm   dnscrypt
docker build -t urykhy/dnscrypt-proxy .

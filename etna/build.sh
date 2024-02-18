#!/bin/sh

docker build -t urykhy/etna \
 --build-arg APT_PROXY=${APT_PROXY} \
 --build-arg PIP_INDEX_URL=${PIP_INDEX_URL} \
 --build-arg PIP_TRUSTED_HOST=${PIP_TRUSTED_HOST} \
 .

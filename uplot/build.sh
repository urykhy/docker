#!/bin/sh

docker build -t urykhy/uplot . --build-arg APT_PROXY=$APT_PROXY

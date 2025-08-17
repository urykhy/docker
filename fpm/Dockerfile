FROM debian:13

ENV VERSION 1.16.0

RUN    apt-get update                             \
    && apt-get install -y --no-install-recommends ruby ruby-dev rubygems build-essential rpm binutils python3 python3-pip python3-setuptools \
    && gem install --clear-sources fpm:$VERSION   \
    && apt-get remove -y ruby-dev build-essential \
    && apt autoremove -y                          \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data

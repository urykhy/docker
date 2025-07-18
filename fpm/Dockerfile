FROM debian:11

ENV VERSION 1.14.2

RUN    apt-get update                             \
    && apt-get install -y --no-install-recommends ruby ruby-dev rubygems build-essential rpm binutils \
    && gem install --clear-sources fpm:$VERSION   \
    && apt-get remove -y ruby-dev build-essential \
    && apt autoremove -y                          \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data

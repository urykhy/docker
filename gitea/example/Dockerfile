# vim:set ft=dockerfile:
FROM debian:bullseye

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    gcc g++ ccache                      \
    meson ninja-build pkg-config        \
    libboost1.71-dev                    \
    libboost-coroutine1.71-dev          \
    libboost-filesystem1.71-dev         \
    libboost-iostreams1.71-dev          \
    libboost-program-options1.71-dev    \
    libboost-system1.71-dev             \
    libboost-test1.71-dev               \
 && rm -rf /var/lib/apt/lists/*

# vim:set ft=dockerfile:
FROM debian:bullseye

RUN sed -ie 's/^deb /deb [trusted=yes] /' /etc/apt/sources.list
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    gcc g++ ccache                      \
    meson ninja-build pkg-config        \
    libboost1.74-dev                    \
    libboost-coroutine1.74-dev          \
    libboost-filesystem1.74-dev         \
    libboost-iostreams1.74-dev          \
    libboost-program-options1.74-dev    \
    libboost-system1.74-dev             \
    libboost-test1.74-dev               \
 && rm -rf /var/lib/apt/lists/*

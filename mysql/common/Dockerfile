FROM debian:jessie-backports

ENV VERSION gpl-7.5.5

RUN apt-get update && \
    apt-get -y install curl libaio1 libnuma1 && \
    curl -fSL https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.5/mysql-cluster-$VERSION-debian8-x86_64.deb -o /tmp/mysql-cluster-$VERSION-debian8-x86_64.deb && \
    dpkg -i /tmp/mysql-cluster-$VERSION-debian8-x86_64.deb && \
    rm /tmp/mysql-cluster-$VERSION-debian8-x86_64.deb && \
    rm -rf /var/lib/apt/lists/*

FROM debian:10

ENV VERSION 0.8.15

RUN echo "deb [trusted=yes] http://repo.mysql.com/apt/debian buster mysql-cluster-8.0" >> /etc/apt/sources.list && \
    apt-get update                            && \
    apt-get -y install curl libaio1 libnuma1 procps && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server mysql-client mysql-cluster-community-data-node mysql-cluster-community-management-server && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /etc/mysql

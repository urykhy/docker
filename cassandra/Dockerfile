# vim:set ft=dockerfile:
FROM debian:jessie-backports

ENV CASSANDRA_VERSION 3.9

RUN    sed -ie 's|httpredir.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && echo 'deb [trusted=yes] http://www.apache.org/dist/cassandra/debian 39x main' >> /etc/apt/sources.list.d/cassandra.list \
    && apt-get update \
    && apt-get install -y cassandra="$CASSANDRA_VERSION" \
    && rm -rf /var/lib/apt/lists/*

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service
EXPOSE 7000 7001 7199 9042 9160

ENV USER=root
ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
CMD ["/usr/sbin/cassandra", "-f", "-R"]
ENTRYPOINT ["/entrypoint.sh"]

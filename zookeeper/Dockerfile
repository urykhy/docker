FROM debian:11

ARG APT_PROXY
RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends openjdk-11-jdk-headless procps iproute2 curl \
    && rm -rf /var/lib/apt/lists/*

ENV ZK_VERSION 3.8.0
ENV ZK_URL http://dlcdn.apache.org/zookeeper/zookeeper-$ZK_VERSION/apache-zookeeper-$ZK_VERSION-bin.tar.gz
RUN set -x                                                          \
 && curl --proxy "${APT_PROXY}" -fSL "$ZK_URL" -o /tmp/zk.tar.gz    \
 && tar -xf /tmp/zk.tar.gz -C /opt/                                 \
 && rm /tmp/zk.tar.gz*                                              \
 && ln -s /opt/apache-zookeeper-$ZK_VERSION-bin/conf /etc/zookeeper \
 && rm /opt/apache-zookeeper-$ZK_VERSION-bin/bin/*.cmd              \
 && rm -r /opt/apache-zookeeper-$ZK_VERSION-bin/docs

ADD zoo.cfg /etc/zookeeper/
ADD entrypoint.sh /
ENV JVMFLAGS="-XX:+UseShenandoahGC -Xms64m -Xmx256m"

WORKDIR /opt/apache-zookeeper-$ZK_VERSION-bin/bin/
ENTRYPOINT ["/entrypoint.sh"]
CMD ["./zkServer.sh", "start-foreground"]
FROM debian:11

ARG APT_PROXY
RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends openjdk-11-jdk-headless wget \
    && rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
ENV SCALA_VERSION 2.13
ENV KAFKA_VERSION 3.2.0
RUN    wget -O - https://dlcdn.apache.org/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz \
     | tar -zxf - -C /opt      \
    && ln -s /opt/* /opt/kafka
ADD https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.17.0/jmx_prometheus_javaagent-0.17.0.jar /opt/jmx_prometheus_javaagent.jar

ADD broker.properties /broker.properties
ADD exporter.yml /exporter.yml

WORKDIR /opt/kafka/bin

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
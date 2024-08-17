FROM debian:11

ARG S_PROXY
ARG APT_PROXY
RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends openjdk-11-jdk-headless wget \
 && rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
ENV SCALA_VERSION 2.13
ENV KAFKA_VERSION 3.6.2
RUN http_proxy=${APT_PROXY} wget http://dlcdn.apache.org/kafka/$KAFKA_VERSION/kafka_$SCALA_VERSION-$KAFKA_VERSION.tgz -O - \
    | tar -zxf - -C /opt      \
 && ln -s /opt/* /opt/kafka
RUN http_proxy=${S_PROXY} wget http://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.17.0/jmx_prometheus_javaagent-0.17.0.jar -O /opt/jmx_prometheus_javaagent.jar

ADD broker.properties /broker.properties
ADD exporter.yml /exporter.yml

# SSL
ADD ssl/ca.crt           /tmp
ADD ssl/server-kafka.crt /tmp
ADD ssl/server-kafka.key /tmp
RUN openssl pkcs12                                                       \
        -export                                                          \
        -in /tmp/server-kafka.crt                                        \
        -inkey /tmp/server-kafka.key                                     \
        -out /tmp/server.p12                                             \
        -passout pass:123456                                             \
 && keytool -importkeystore                                              \
        -destkeystore /etc/kafka.jks                                     \
        -deststorepass 123456 -destkeypass 123456                        \
        -srckeystore /tmp/server.p12                                     \
        -srcstorepass 123456

RUN openssl x509 -outform der -in /tmp/ca.crt -out /tmp/ca.der           \
 && keytool -import -noprompt                                            \
        -keystore /etc/ca.jks -trustcacerts                              \
        -deststorepass 123456                                            \
        -file /tmp/ca.der

WORKDIR /opt/kafka/bin
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

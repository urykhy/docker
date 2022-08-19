FROM debian:11

ARG APT_PROXY
RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends openjdk-11-jdk-headless procps iproute2 curl unzip \
    && rm -rf /var/lib/apt/lists/*

ENV NIFI_VERSION 1.17.0
ENV NIFI_URL http://dlcdn.apache.org/nifi/$NIFI_VERSION/nifi-$NIFI_VERSION-bin.zip

RUN set -x                                                         \
 && curl --proxy "${APT_PROXY}" -fSL "$NIFI_URL" -o /tmp/nifi.zip  \
 && unzip /tmp/nifi.zip -d /opt/                                   \
 && rm /tmp/*.zip

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
ENV NIFI_HOME /opt/nifi-$NIFI_VERSION
ENV NIFI_LOG_DIR /data/logs
ENV NIFI_PID_DIR /tmp/
ENV SINGLE_USER_CREDENTIALS_USERNAME admin
ENV SINGLE_USER_CREDENTIALS_PASSWORD admin

ADD bootstrap.conf ${NIFI_HOME}/conf/
ADD nifi.properties ${NIFI_HOME}/conf/
ADD state-management.xml ${NIFI_HOME}/conf/
ADD login-identity-providers.xml ${NIFI_HOME}/conf/
ADD authorizers.xml ${NIFI_HOME}/conf/
ADD entrypoint.sh /

ENV JVMFLAGS="-XX:+UseShenandoahGC -Xms64m -Xmx2g"
RUN echo "#!/bin/sh\n" > $NIFI_HOME/bin/nifi-env.sh

WORKDIR ${NIFI_HOME}
CMD ["/entrypoint.sh"]
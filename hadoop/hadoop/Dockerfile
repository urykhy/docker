FROM golang:1.17-stretch AS forego
ARG  GOPROXY
RUN  go install github.com/ddollar/forego@master

FROM minio/minio:RELEASE.2022-04-16T04-26-02Z AS minio

FROM debian:11

ARG S_PROXY
ARG APT_PROXY
RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends openjdk-11-jdk-headless \
 && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends jsvc net-tools curl python krb5-user libssl-dev libzstd-dev libsnappy-dev procps

ENV HADOOP_VERSION 3.2.2
ENV HADOOP_URL http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN set -x                                                              \
 && http_proxy=${S_PROXY} curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
 && tar -xvf /tmp/hadoop.tar.gz -C /opt/                                \
 && rm /tmp/hadoop.tar.gz                                               \
 && rm -rf /opt/hadoop-$HADOOP_VERSION/share/doc/hadoop

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop
RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=/etc/hadoop

ENV USER=root
ENV PATH=$HADOOP_HOME/bin/:$PATH
RUN ln -vsf $HADOOP_HOME/lib/native/lib* /usr/lib/

ADD core-site.xml    /etc/hadoop/
ADD hdfs-site.xml    /etc/hadoop/
ADD httpfs-site.xml  /etc/hadoop/
ADD kms-site.xml     /etc/hadoop/
ADD mapred-site.xml  /etc/hadoop/
ADD yarn-site.xml    /etc/hadoop/
ADD kms.keystore.password /etc/hadoop/

# SSL
ADD ssl-server.xml   /etc/hadoop/
ADD ca.crt                       /tmp
ADD server-kms.hadoop.docker.crt /tmp
ADD server-kms.hadoop.docker.key /tmp
RUN openssl pkcs12                                                                   \
        -export                                                                      \
        -in /tmp/server-kms.hadoop.docker.crt                                        \
        -inkey /tmp/server-kms.hadoop.docker.key                                     \
        -out /tmp/kms.hadoop.docker.p12                                              \
        -passout pass:123456                                                         \
 && keytool -importkeystore                                                          \
        -keystore /etc/hadoop/ssl.keystore -deststorepass 123456 -destkeypass 123456 \
        -srckeystore /tmp/kms.hadoop.docker.p12 -srcstorepass 123456                 \
 && openssl x509 -outform der -in /tmp/ca.crt -out /tmp/ca.der                       \
 && keytool -import                                                                  \
        -keystore /etc/ssl/certs/java/cacerts -deststorepass changeit -trustcacerts  \
        -file /tmp/ca.der -noprompt

    # add kms.hadoop.docker.p12 system java certs
    #keytool -importkeystore                                                          \
    #    -keystore /etc/ssl/certs/java/cacerts -deststorepass changeit -trustcacerts  \
    #    -srckeystore /tmp/kms.hadoop.docker.p12 -srcstorepass 123456

ADD namenode.sh          /
ADD datanode.proc        /
ADD resourcemanager.proc /
RUN rm /etc/hadoop/kms-log4j.properties

# Kerberos support
ADD krb5.conf        /etc/
ADD minio.keytab     /etc
ADD kerberos.keytab  /etc/hadoop/kerberos.keytab

ADD entrypoint.sh    /
ENTRYPOINT ["/entrypoint.sh"]
ENV HADOOP_OPTS="-Djava.net.preferIPv4Stack=true -XX:+UseShenandoahGC -Xms64m -Xmx256m"

ARG WITH_KERBEROS=true
ENV WITH_KERBEROS=$WITH_KERBEROS
RUN if [ "$WITH_KERBEROS" != "true" ]; then sed -i '/KERBEROS BEGIN/,/KERBEROS END/d' /etc/hadoop/*.xml; fi

COPY --from=minio    /opt/bin/minio /usr/bin/
COPY --from=forego   /go/bin/forego /usr/bin/

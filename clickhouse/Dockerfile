FROM golang:1.17-stretch AS gosu
ARG  GOPROXY
RUN  go install github.com/tianon/gosu@1.14

FROM clickhouse/clickhouse-server:24.9

ADD metrika.xml   /etc/metrika.xml
ADD config.xml    /etc/clickhouse-server/config.xml
ADD users.xml     /etc/clickhouse-server/users.xml
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
USER root

COPY --from=gosu /go/bin/gosu /usr/bin/

ARG WITH_HDFS=true
RUN if [ "$WITH_HDFS" != "true" ]; then sed -i '/clickhouse_storage_configuration/,/<\/clickhouse_backups>/d' /etc/metrika.xml; fi

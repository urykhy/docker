FROM golang:1.17-stretch AS backup
RUN  go install github.com/AlexAkulov/clickhouse-backup/cmd/clickhouse-backup@v1.3.1

FROM golang:1.17-stretch AS gosu
RUN  go install github.com/tianon/gosu@1.14

FROM clickhouse/clickhouse-server:23.1

ADD metrika.xml   /etc/metrika.xml
ADD config.xml    /etc/clickhouse-server/config.xml
ADD users.xml     /etc/clickhouse-server/users.xml
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
USER root

ADD clickhouse-backup.yml /etc/clickhouse-backup/config.yml

COPY --from=gosu   /go/bin/gosu /usr/bin/
COPY --from=backup /go/bin/clickhouse-backup /usr/bin/

ARG WITH_HDFS=true
RUN if [ "$WITH_HDFS" != "true" ]; then sed -i '/clickhouse_storage_configuration/,/<\/clickhouse_backups>/d' /etc/metrika.xml; fi

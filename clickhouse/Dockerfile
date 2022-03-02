FROM golang:1.17-stretch AS backup
RUN  go install github.com/AlexAkulov/clickhouse-backup/cmd/clickhouse-backup@v1.3.1

FROM golang:1.17-stretch AS gosu
RUN  go install github.com/tianon/gosu@master

FROM yandex/clickhouse-server:22.1.3.7

ADD metrika.xml   /etc/metrika.xml
ADD config.xml    /etc/clickhouse-server/config.xml
ADD users.xml     /etc/clickhouse-server/users.xml
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
USER root

ADD clickhouse-backup.yml /etc/clickhouse-backup/config.yml

COPY --from=gosu   /go/bin/gosu /usr/bin/
COPY --from=backup /go/bin/clickhouse-backup /usr/bin/

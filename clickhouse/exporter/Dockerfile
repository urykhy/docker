FROM golang:1.17-stretch AS forego
RUN go install github.com/ddollar/forego@master

FROM golang:1.17-stretch AS exporter
RUN go install github.com/ClickHouse/clickhouse_exporter@master

FROM debian:stretch
ADD Procfile /
CMD ["forego", "start", "-r", "-f", "/Procfile"]

COPY --from=exporter /go/bin/clickhouse_exporter /usr/bin/
COPY --from=forego   /go/bin/forego /usr/bin/
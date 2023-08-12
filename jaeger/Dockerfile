FROM jaegertracing/jaeger-query:1.47 AS query
FROM jaegertracing/jaeger-collector:1.47 AS collector
FROM golang:1.18-stretch AS builder
RUN  go install github.com/jaegertracing/jaeger-clickhouse/cmd/jaeger-clickhouse@0.12.0

FROM debian:11
COPY --from=builder     /go/bin/jaeger-clickhouse /usr/bin/
COPY --from=query       /go/bin/query-linux /usr/bin/jaeger-query
COPY --from=collector   /go/bin/collector-linux /usr/bin/jaeger-collector

ADD plugin.yaml /etc/jaeger-clickhouse.yaml
ENV SPAN_STORAGE_TYPE=grpc-plugin
ENV GRPC_STORAGE_PLUGIN_BINARY=/usr/bin/jaeger-clickhouse
ENV GRPC_STORAGE_PLUGIN_CONFIGURATION_FILE=/etc/jaeger-clickhouse.yaml
ENV GRPC_STORAGE_PLUGIN_LOG_LEVEL=debug

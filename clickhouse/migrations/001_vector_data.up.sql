CREATE TABLE vector_data ON CLUSTER events (
    date            Date MATERIALIZED timestamp,
    timestamp       DateTime,
    container_name  String,
    message         String,
    INDEX idx0 container_name TYPE set(10) GRANULARITY 1
) ENGINE = ReplicatedMergeTree('/clickhouse/tables/vector_data/{shard}', '{host}')
  PARTITION BY date
  ORDER BY (timestamp, container_name)
  TTL date + INTERVAL 1 MONTH;

CREATE TABLE vector (
    date            Date MATERIALIZED timestamp,
    timestamp       DateTime,
    container_name  String,
    message         String
) ENGINE = Distributed(events, default, vector_data, rand());

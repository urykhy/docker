ALTER TABLE vector_data ON CLUSTER events
    ADD COLUMN __timestamp DateTime64(6) ALIAS        IF(container_name like 'clickhouse%', parseDateTime64BestEffortOrZero(mid(message, 1, 26), 6), toDateTime64(0, 6)),
    ADD COLUMN x_timestamp DateTime64(6) MATERIALIZED IF(__timestamp>0, __timestamp, toDateTime64(timestamp, 6)),
    ADD INDEX  x_timestamp_idx(x_timestamp) TYPE minmax GRANULARITY 1;

ALTER TABLE vector
    ADD COLUMN __timestamp DateTime64(6) ALIAS        IF(container_name like 'clickhouse%', parseDateTime64BestEffortOrZero(mid(message, 1, 26), 6), toDateTime64(0, 6)),
    ADD COLUMN x_timestamp DateTime64(6) MATERIALIZED IF(__timestamp>0, __timestamp, toDateTime64(timestamp, 6));

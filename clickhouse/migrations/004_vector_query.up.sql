ALTER TABLE vector_data ON CLUSTER events
    ADD COLUMN   __query UInt64 ALIAS         IF (startsWith(container_name, 'clickhouse'), locate(message, '<Debug> executeQuery:'), 0) AFTER uuid,
    ADD COLUMN     query String MATERIALIZED  IF (__query > 0, substring(message, __query + 22, 1024), '') AFTER __query,
    ADD INDEX  query_idx(query) TYPE tokenbf_v1(128, 3, 42) GRANULARITY 1;

ALTER TABLE vector
    ADD COLUMN   __query UInt64 ALIAS         IF (startsWith(container_name, 'clickhouse'), locate(message, '<Debug> executeQuery:'), 0) AFTER uuid,
    ADD COLUMN     query String MATERIALIZED  IF (__query > 0, substring(message, __query + 22, 1024), '') AFTER __query

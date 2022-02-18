ALTER TABLE vector_data ON CLUSTER events
    ADD COLUMN  __uuid String ALIAS        IF (startsWith(container_name, 'clickhouse'), splitByWhitespace(message)[6], '') AFTER message,
    ADD COLUMN    uuid String MATERIALIZED IF (startsWith(__uuid, '{') AND endsWith(__uuid, '}') AND length(__uuid) > 2, __uuid, '') AFTER __uuid,
    ADD INDEX  uuid_idx(uuid) TYPE bloom_filter GRANULARITY 1;

ALTER TABLE vector
    ADD COLUMN  __uuid String ALIAS        IF (startsWith(container_name, 'clickhouse'), splitByWhitespace(message)[6], '') AFTER message,
    ADD COLUMN    uuid String MATERIALIZED IF (startsWith(__uuid, '{') AND endsWith(__uuid, '}') AND length(__uuid) > 2, __uuid, '') AFTER __uuid;

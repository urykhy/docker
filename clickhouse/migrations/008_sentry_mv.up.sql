CREATE TABLE sentry1 (
    date            Date     MATERIALIZED timestamp,
    timestamp       DateTime,
    level           String,
    message         String,
    environment     String,
    server_name     String,
    release         String,
    transaction     String,
    event_id        String,
    app_name        String,
    ex_type         String,
    ex_message      String,
    INDEX  event_idx(event_id) TYPE bloom_filter GRANULARITY 1,
    INDEX  transaction_idx(transaction) TYPE bloom_filter GRANULARITY 1
) ENGINE = MergeTree
  PARTITION BY date
  ORDER BY (timestamp, transaction, event_id);

CREATE MATERIALIZED VIEW sentry1_mv TO sentry1 AS
  WITH o::String AS x
SELECT toDateTime(JSON_VALUE(x, '$.timestamp'))  AS timestamp,
       JSON_VALUE(x, '$.level')            AS level,
       JSON_VALUE(x, '$.message.message')  AS message,
       JSON_VALUE(x, '$.environment')      AS environment,
       JSON_VALUE(x, '$.server_name')      AS server_name,
       JSON_VALUE(x, '$.release')          AS release,
       JSON_VALUE(x, '$.transaction')      AS transaction,
       JSON_VALUE(x, '$.event_id')         AS event_id,
       JSON_VALUE(x, '$.contexts.app.app_name') AS app_name,
       JSON_VALUE(x, '$.exception.type')   AS ex_type,
       JSON_VALUE(x, '$.exception.value')  AS ex_message
FROM sentry;

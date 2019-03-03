CREATE MATERIALIZED VIEW hitlog ON CLUSTER sharded
  ENGINE = AggregatingMergeTree(date, (date), 8192)
    AS SELECT toDate('1971-01-01') as date, minState(EventTime) AS start, maxState(EventTime) AS end FROM hits_2;

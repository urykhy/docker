CREATE TABLE hits_1 ON CLUSTER replicated (
    EventDate MATERIALIZED toDate(EventTime),
    EventTime DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = ReplicatedMergeTree('/clickhouse/tables/layer1-shard1/hits', '{host}', EventDate, (EventDate, UserID), 8192)

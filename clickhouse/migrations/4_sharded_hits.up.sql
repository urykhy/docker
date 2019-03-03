CREATE TABLE hits_2 ON CLUSTER sharded (
    EventDate Date,
    EventTime DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = MergeTree(EventDate, (EventDate, UserID), 8192)

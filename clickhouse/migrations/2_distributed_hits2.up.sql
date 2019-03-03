CREATE TABLE hits_2 (
    EventDate MATERIALIZED toDate(EventTime),
    EventTime DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = Distributed(sharded, default, hits_2, cityHash64(CounterID, UserID))

CREATE TABLE hits_1 (
    EventDate MATERIALIZED toDate(EventTime),
    EventTime DateTime,
    CounterID UInt32,
    UserID UInt32
) ENGINE = Distributed(replicated, default, hits_1)

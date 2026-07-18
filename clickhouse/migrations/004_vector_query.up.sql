ALTER TABLE vector_data ON CLUSTER events
    ADD COLUMN     query String MATERIALIZED  extract(message, '.*] {[^}]+} <Debug> executeQuery: \([^)]+\) (.*) \(stage: [^)+]\)?') AFTER uuid,
    ADD INDEX  query_idx(query) TYPE tokenbf_v1(128, 3, 42) GRANULARITY 1;

ALTER TABLE vector
    ADD COLUMN     query String MATERIALIZED  extract(message, '.*] {[^}]+} <Debug> executeQuery: \([^)]+\) (.*) \(stage: [^)+]\)?') AFTER uuid

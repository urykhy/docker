ALTER TABLE vector
    DROP COLUMN query;

ALTER TABLE vector_data ON CLUSTER events
    DROP INDEX query_idx;

ALTER TABLE vector_data ON CLUSTER events
    DROP COLUMN query;

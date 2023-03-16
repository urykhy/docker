ALTER TABLE vector
    DROP COLUMN x_timestamp,
    DROP COLUMN __timestamp;

ALTER TABLE vector_data ON CLUSTER events
    DROP INDEX x_timestamp_idx;

ALTER TABLE vector_data ON CLUSTER events
    DROP COLUMN x_timestamp,
    DROP COLUMN __timestamp;

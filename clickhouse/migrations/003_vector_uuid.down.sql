ALTER TABLE vector
    DROP COLUMN uuid,
    DROP COLUMN __uuid;

ALTER TABLE vector_data ON CLUSTER events
    DROP INDEX uuid_idx;

ALTER TABLE vector_data ON CLUSTER events
    DROP COLUMN uuid,
    DROP COLUMN __uuid;

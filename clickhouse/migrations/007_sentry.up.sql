CREATE TABLE sentry(o JSON) ENGINE = MergeTree PARTITION BY tuple() ORDER BY tuple();
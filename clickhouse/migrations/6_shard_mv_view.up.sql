CREATE VIEW hitlog2 ON CLUSTER sharded
  AS SELECT minMerge(start) AS start,maxMerge(end) AS end FROM hitlog;

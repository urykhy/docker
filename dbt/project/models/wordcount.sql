{{ config(materialized='table', order_by='(w)', engine='MergeTree()') }}

SELECT arrayJoin(splitByNonAlpha(line)) AS w, count() AS c
  FROM s3Cluster('events', '{{ var("s3") }}/{{ var("files") }}', '{{ var("access_key") }}', '{{ var("secret_key") }}', 'LineAsString')
 GROUP BY w

{{ config(materialized='view') }}

SELECT w, sum(c) AS s FROM {{ ref('wordcount') }} GROUP BY w ORDER BY s DESC

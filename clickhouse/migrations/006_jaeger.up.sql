CREATE MATERIALIZED VIEW zipkin_spans ON CLUSTER events
ENGINE = URL('http://collector.jaeger:9411/api/v2/spans', 'JSONEachRow')
SETTINGS output_format_json_named_tuples_as_objects = 1, output_format_json_array_of_rows = 1, output_format_json_quote_64bit_integers=0 AS
SELECT
	lower(hex(trace_id)) AS traceId,
	case when parent_span_id = 0 then '' else lower(hex(parent_span_id)) end AS parentId,
	lower(hex(span_id)) AS id,
	operation_name AS name,
	start_time_us AS timestamp,
	finish_time_us - start_time_us AS duration,
	cast(tuple('clickhouse'), 'Tuple(serviceName text)') AS localEndpoint,
	cast(tuple(attribute.values[indexOf(attribute.names, 'db.statement')]),	'Tuple("db.statement" text)') AS tags
FROM system.opentelemetry_span_log;

CREATE MATERIALIZED VIEW zipkin_spans
ENGINE = URL('http://collector.jaeger:9411/api/v2/spans', 'JSONEachRow')
SETTINGS output_format_json_named_tuples_as_objects = 1, output_format_json_array_of_rows = 1, output_format_json_quote_64bit_integers=0 AS
SELECT
	lower(hex(trace_id)) AS traceId,
	case when parent_span_id = 0 then '' else lower(hex(parent_span_id)) end AS parentId,
	lower(hex(span_id)) AS id,
	operation_name AS name,
	start_time_us AS timestamp,
	finish_time_us - start_time_us AS duration,
	cast(tuple('clickhouse'), 'Tuple(serviceName text)') AS localEndpoint,
	cast(tuple(attribute.values[indexOf(attribute.names, 'db.statement')]),	'Tuple("db.statement" text)') AS tags
FROM system.opentelemetry_span_log;

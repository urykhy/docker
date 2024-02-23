# create connection:
# docker compose exec airflow gosu airflow \
#        airflow connections add s3_master --conn-uri 'aws://minio:minio123@/?host=http%3A%2F%2Felf.dark%3A9000'
# docker cp click_duck.py airflow-server:/airflow/dags/
from __future__ import annotations

from datetime import datetime
import os
import requests
import duckdb

from airflow import DAG
from airflow.decorators import task
from airflow.providers.amazon.aws.hooks.s3 import S3Hook
from airflow.utils.dates import days_ago
from airflow_clickhouse_plugin.hooks.clickhouse import ClickHouseHook
from urllib.parse import urlparse

DAGNAME="clickhouse-duckdb-parquet"

s3 = S3Hook("s3_master")
url = s3.generate_presigned_url(client_method="get_object", params={"Bucket": "test", "Key": "dummy"})
url = url.split("?")[0]
url = url[: url.rfind("/")]
cred = s3.get_session().get_credentials().get_frozen_credentials()

@task
def prepare():
    query = f"INSERT INTO function s3('{url}/ch.parquet', '{cred.access_key}', '{cred.secret_key}') SELECT toString(number%12345) s, number%12345 n from numbers(1e8) SETTINGS s3_truncate_on_insert=1 FORMAT Parquet"
    ch = ClickHouseHook(clickhouse_conn_id="clickhouse_master")
    return ch.execute(query)

@task
def calc(arg):
    conn = duckdb.connect("/tmp/dummy.db")
    r = conn.sql(f"""
    INSTALL httpfs;
    LOAD httpfs;
    SET s3_region='us-east-1';
    SET s3_url_style='path';
    SET s3_endpoint='{urlparse(url).netloc}';
    SET s3_access_key_id='{cred.access_key}';
    SET s3_secret_access_key='{cred.secret_key}';
    SET s3_use_ssl = false;
    SELECT count() FROM read_parquet('s3://test/ch.parquet') WHERE n = 123
    """).fetchall()
    return r

with DAG(dag_id=DAGNAME, start_date=days_ago(2), schedule=None) as dag:
    a = prepare()
    b = calc(a)

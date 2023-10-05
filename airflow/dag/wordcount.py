# create connection:
# docker compose exec airflow gosu airflow \
#        airflow connections add s3_master --conn-uri 'aws://minio:minio123@/?host=http%3A%2F%2Felf.dark%3A9000'
# docker cp wordcount.py airflow-server:/airflow/dags/
from __future__ import annotations

from datetime import datetime
import os
import requests

from airflow import DAG
from airflow.decorators import task
from airflow.providers.amazon.aws.hooks.s3 import S3Hook
from airflow.utils.dates import days_ago
from airflow_clickhouse_plugin.hooks.clickhouse import ClickHouseHook

DAGNAME="clickhouse-wordcount"
BUCKET=DAGNAME
CLUSTER="events"

@task
def prepare():
    s3 = S3Hook("s3_master")
    if not s3.check_for_bucket(BUCKET):
        s3.create_bucket(BUCKET)
    if not s3.check_for_key("4300-0.txt", BUCKET):
        r = requests.get("https://www.gutenberg.org/files/4300/4300-0.txt")
        r.raise_for_status()
        s3.load_bytes(r.content, "4300-0.txt", BUCKET)
    if not s3.check_for_key("pg20417.txt", BUCKET):
        r = requests.get("https://www.gutenberg.org/cache/epub/20417/pg20417.txt", BUCKET)
        r.raise_for_status()
        s3.load_bytes(r.content, "pg20417.txt", BUCKET)
    return 0

@task
def calc(arg):
    s3 = S3Hook("s3_master")
    url = s3.generate_presigned_url(client_method="get_object", params={"Bucket": BUCKET, "Key": "dummy"})
    url = url.split("?")[0]
    url = url[: url.rfind("/")]
    cred = s3.get_session().get_credentials().get_frozen_credentials()

    query = """
    SELECT arrayJoin(splitByNonAlpha(line)) AS w, count() AS c
      FROM s3Cluster('{cluster}', '{url}/{{4300-0.txt,pg20417.txt}}', '{access_key}', '{secret_key}', 'LineAsString')
     GROUP BY w ORDER BY c DESC LIMIT 10
    """.format(cluster=CLUSTER, url=url, access_key=cred.access_key, secret_key=cred.secret_key)

    ch = ClickHouseHook(clickhouse_conn_id="clickhouse_master")
    return ch.execute(query)

with DAG(dag_id=DAGNAME, start_date=days_ago(2), schedule=None) as dag:
    a = prepare()
    b = calc(a)

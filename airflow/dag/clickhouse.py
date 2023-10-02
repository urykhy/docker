# docker compose exec airflow gosu airflow airflow connections add 'clickhouse_master' --conn-uri 'clickhouse://master.clickhouse.docker:9000'
# docker cp clickhouse.py airflow-server:/airflow/dags/

from __future__ import annotations

from datetime import datetime

from airflow import DAG
from airflow_clickhouse_plugin.hooks.clickhouse import ClickHouseHook
from airflow.decorators import task
from airflow.utils.dates import days_ago

@task
def prepare():
    ch = ClickHouseHook(clickhouse_conn_id="clickhouse_master")
    return ch.execute('select distinct container_name from vector where date=today()')

@task
def map(arg):
    print("map: ", arg)
    ch = ClickHouseHook(clickhouse_conn_id="clickhouse_master")
    return (arg, ch.execute(f"select count() from vector where date=today() and container_name='{arg[0]}'"))

@task
def reduce(arg):
    print("reduce: ", arg)
    res = 0
    for (x, y) in arg:
        res += y[0][0]
    return res

with DAG(dag_id="clickhouse-map-reduce", start_date=days_ago(2), schedule=None) as dag:
    a = prepare()
    b = map.expand(arg=a)
    c = reduce(b)

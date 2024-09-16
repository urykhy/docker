# docker cp prophet.py airflow-server:/airflow/dags/

from __future__ import annotations

from airflow import DAG
from airflow.decorators import task
from airflow.utils.dates import days_ago

DAGNAME = "fb-prophet"


@task
def prepare():
    c = [
        ["ds", "y"],
        ["2024-01-01", 30],
        ["2024-02-01", 22],
        ["2024-03-01", 22],
        ["2024-04-01", 22],
        ["2024-05-01", 25],
        ["2024-06-01", 27],
        ["2024-07-01", 29],
        ["2024-08-01", 30],
        ["2024-09-01", 33],
        ["2024-10-01", 32],
        ["2024-11-01", 31],
        ["2024-12-01", 32],
    ]
    return c


@task.virtualenv(system_site_packages=False, requirements=["prophet", "pandas"], venv_cache_path="/tmp/venv-cached")
def calc(data):
    PREDICTIONS = 12
    import numpy as np

    np.float_ = np.float64
    import pandas as pd
    import logging
    from prophet import Prophet
    import json

    train = pd.DataFrame(data[1:], columns=data[0])
    logging.getLogger("prophet.plot").disabled = True
    m = Prophet()
    m.fit(train)
    forecast = m.predict(m.make_future_dataframe(periods=PREDICTIONS, freq="m"))
    x = forecast[["ds", "yhat"]]
    return json.dumps(x.values.tolist(), default=str)


@task
def out(arg):
    import json
    from tabulate import tabulate

    print(tabulate(json.loads(arg)))


with DAG(dag_id=DAGNAME, start_date=days_ago(2), schedule=None) as dag:
    a = prepare()
    b = calc(a)
    out(b)

# create connection:
# docker compose exec airflow gosu airflow \
#        airflow connections add jenkins_master --conn-uri 'http://admin:112b48b38c24d2e0fc7e4847540937fc28@jenkins:8080'
#
# put dag to airflow:
# docker cp airflow_j.py airflow-server:/airflow/dags/

import os
from datetime import datetime

from airflow import DAG
from airflow.providers.jenkins.operators.jenkins_job_trigger import (
    JenkinsJobTriggerOperator,
)
from airflow.utils.dates import days_ago
from requests import Request

with DAG(
    "jenkins_mapreduce",
    start_date=days_ago(2),
    schedule_interval=None,
) as dag:
    job = JenkinsJobTriggerOperator(
        task_id="jenkins_mapreduce",
        job_name="mapreduce/master",
        jenkins_connection_id="jenkins_master",
    )

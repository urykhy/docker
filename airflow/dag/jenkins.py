# create connection:
# docker compose exec airflow gosu airflow \
#        airflow connections add jenkins_master --conn-uri 'http://admin:118aa1737abc4baa35d42b88279af89fc1@jenkins:8080'
#
# put dag to airflow:
# docker cp jenkins.py airflow-server:/airflow/dags/

import os
from datetime import datetime

from airflow import DAG
from airflow.providers.jenkins.operators.jenkins_job_trigger import (
    JenkinsJobTriggerOperator,
)
from airflow.utils.dates import days_ago
from requests import Request

with DAG(
    "jenkins-hadoop-mapreduce",
    start_date=days_ago(2),
    schedule_interval=None,
) as dag:
    job = JenkinsJobTriggerOperator(
        task_id="jenkins",
        job_name="mapreduce",
        jenkins_connection_id="jenkins_master",
    )

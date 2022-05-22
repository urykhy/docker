#!/bin/bash

if [ ! -f /airflow/init.done ]; then
    mkdir /airflow/{dags,logs,plugins}
    airflow db init
    airflow users create --username admin --firstname airflow --lastname admin --email admin@example.com --role Admin --password admin
    touch /airflow/init.done
    chown -R airflow: /airflow
fi

exec gosu airflow forego start -r -f /Procfile

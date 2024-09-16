FROM golang:1.17-stretch AS gosu
ARG  GOPROXY
RUN  go install github.com/tianon/gosu@master

FROM debian:11
ARG APT_PROXY
ARG PIP_INDEX_URL
ARG PIP_TRUSTED_HOST

RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN    apt-get update               \
    && apt-get -y install eatmydata \
    && eatmydata apt-get install    \
       -y                           \
       --no-install-recommends      \
       procps                       \
       libkrb5-dev gcc              \
       python3 python3-dev          \
       python3-pip python3-redis    \
       virtualenv                   \
    && rm -rf /var/lib/apt/lists/*

RUN eatmydata pip install --no-cache-dir "apache-airflow[celery,postgres,hdfs,ssh,sftp,amazon]==2.10.1" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.10.1/constraints-3.9.txt"
RUN eatmydata pip install --no-cache-dir "airflow-clickhouse-plugin==1.4.0"
RUN eatmydata pip install --no-cache-dir "apache-airflow-providers-jenkins==3.7.0"
RUN eatmydata pip install --no-cache-dir "airflow-provider-duckdb==0.2.0"

RUN useradd -ms /bin/bash airflow
RUN mkdir /airflow
WORKDIR /airflow

COPY --from=gosu   /go/bin/gosu   /usr/bin/
ADD run.sh /

ENV PIP_INDEX_URL=$PIP_INDEX_URL
ENV PIP_TRUSTED_HOST=$PIP_TRUSTED_HOST

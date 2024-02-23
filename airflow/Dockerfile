FROM golang:1.17-stretch AS forego
RUN  go install github.com/ddollar/forego@master

FROM golang:1.17-stretch AS gosu
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
    && rm -rf /var/lib/apt/lists/*

RUN eatmydata pip install --no-cache-dir "apache-airflow[celery,postgres,hdfs,ssh,sftp,amazon]==2.7.1" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.7.1/constraints-3.9.txt"
RUN eatmydata pip install --no-cache-dir "airflow-clickhouse-plugin"
RUN eatmydata pip install --no-cache-dir "apache-airflow-providers-jenkins"
RUN eatmydata pip install --no-cache-dir "airflow-provider-duckdb"

RUN useradd -ms /bin/bash airflow
RUN mkdir /airflow
WORKDIR /airflow

COPY --from=gosu   /go/bin/gosu   /usr/bin/
COPY --from=forego /go/bin/forego /usr/bin/

ADD run.sh /
ADD Procfile /

FROM debian:11

ARG APT_PROXY
ARG PIP_INDEX_URL
ARG PIP_TRUSTED_HOST

RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN echo "deb http://mirror.yandex.ru/debian bullseye main non-free contrib" > /etc/apt/sources.list.d/docker.list \
 && apt-get -o Acquire::Check-Valid-Until=false update \
 && apt-get -y --no-install-recommends install  \
            python3-pip python3-setuptools      \
            git                                 \
 && rm -rf /var/lib/apt/lists/*

RUN pip install dbt-core==1.1.0 dbt-mysql==1.1.0 dbt-clickhouse pytz && rm -rf /root/.cache

RUN adduser --uid 1000 user
USER user
WORKDIR /home/user

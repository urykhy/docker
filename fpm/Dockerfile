FROM debian:13

ENV VERSION 1.17.0
ARG APT_PROXY
ARG PIP_INDEX_URL
ARG PIP_TRUSTED_HOST
ENV PIP_INDEX_URL=${PIP_INDEX_URL}
ENV PIP_TRUSTED_HOST=${PIP_TRUSTED_HOST}

RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN    apt-get update                             \
    && apt-get install -y --no-install-recommends ruby ruby-dev rubygems build-essential rpm binutils python3 python3-pip unzip \
    && gem install --clear-sources fpm:$VERSION   \
    && pip install --break-system-packages "setuptools<82"\
    && apt-get remove -y ruby-dev build-essential \
    && apt autoremove -y                          \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data

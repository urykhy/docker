FROM debian:bookworm

ARG APT_PROXY
ARG PIP_INDEX_URL
ARG PIP_TRUSTED_HOST

RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3-cherrypy3 \
    python3-mysqldb python3-sqlalchemy-ext python3-sqlalchemy \
    python3-pip python3-setuptools python3-wheel procps less \
    uwsgi-plugin-python3 uwsgi-plugin-php \
 && rm -rf /var/lib/apt/lists/*

ENV USER=root
ADD flibusta.ini /
ADD torrent.ini  /
ADD php.ini      /

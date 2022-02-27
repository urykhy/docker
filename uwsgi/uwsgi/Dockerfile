FROM golang:1.17-stretch AS forego
RUN go install github.com/ddollar/forego@master

FROM debian:buster

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       python3-cherrypy3 python3-elasticsearch \
       python-pip python-setuptools python-wheel procps less \
       uwsgi-plugin-python3 \
       uwsgi-plugin-php \
    && pip install elasticsearch_dsl \
    && rm -rf /var/lib/apt/lists/*

ENV USER=root
ADD flibusta.ini /
ADD torrent.ini  /
ADD php.ini      /
ADD uwsgi.proc   /

COPY --from=forego   /go/bin/forego /usr/bin/

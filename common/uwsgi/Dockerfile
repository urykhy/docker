FROM debian:buster

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       python3-cherrypy3 python3-elasticsearch \
       supervisor python-pip python-setuptools python-wheel procps less \
       uwsgi-plugin-python3 \
    && pip install elasticsearch_dsl \
    && rm -rf /var/lib/apt/lists/*

ENV USER=root
ADD flibusta.ini /
ADD torrent.ini  /
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]

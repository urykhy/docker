FROM debian:buster

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       samba pure-ftpd-ldap syncthing  supervisor python-pip python-setuptools python-wheel procps less \
    && pip install supervisor-stdout \
    && rm -rf /var/lib/apt/lists/*

ENV USER=root
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]

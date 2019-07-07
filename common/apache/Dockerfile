FROM debian:buster

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       composer apache2 apache2-data apache2-utils libapache2-mod-fcgid libapache2-mod-wsgi-py3 php7.3-fpm php7.3-sqlite3 \
       python3-cherrypy3 python3-elasticsearch \
       supervisor python-pip python-setuptools python-wheel procps less \
    && pip install supervisor-stdout elasticsearch_dsl \
    && rm -rf /var/lib/apt/lists/*

ENV USER=root
RUN mkdir        /etc/fpm/
ADD php-fpm.conf /etc/fpm/
ADD pool.conf    /etc/fpm/
RUN mkdir /var/log/apache2/virtual/ && chown www-data: /var/log/apache2/virtual/
RUN mkdir /run/php/ && chown www-data: /run/php/
ENV APACHE_LOCK_DIR=/var/lock/apache2
ENV APACHE_PID_FILE=/var/run/apache2/apache2.pid
ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV APACHE_LOG_DIR=/var/log/apache2
ENV APACHE_RUN_DIR=/var/run/apache2
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]

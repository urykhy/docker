FROM yandex/clickhouse-server:22.1.3.7

ADD metrika.xml   /etc/metrika.xml
ADD config.xml    /etc/clickhouse-server/config.xml
ADD users.xml     /etc/clickhouse-server/users.xml
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
USER root
#ENTRYPOINT ["/usr/bin/clickhouse-server","--config=/etc/clickhouse-server/config.xml"]

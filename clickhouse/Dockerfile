FROM yandex/clickhouse-server

ADD metrika.xml /etc/metrika.xml
RUN sed -i 's,<listen_host>::</listen_host>,<listen_host>0.0.0.0</listen_host>,' /etc/clickhouse-server/config.xml
RUN sed -i 's,<listen_host>::1</listen_host>,,' /etc/clickhouse-server/config.xml
RUN sed -i 's,<!-- <console>1</console> -->,<console>1</console>,' /etc/clickhouse-server/config.xml

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
USER root
#ENTRYPOINT ["/usr/bin/clickhouse-server","--config=/etc/clickhouse-server/config.xml"]

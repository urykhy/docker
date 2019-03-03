FROM urykhy/hadoop

ENV SPARK_URL http://www-eu.apache.org/dist/spark/spark-2.0.1/spark-2.0.1-bin-hadoop2.7.tgz

RUN set -x \
    && curl -fSL "$SPARK_URL" -o /tmp/spark.tar.gz \
    && tar -xvf /tmp/spark.tar.gz -C /opt \
    && rm /tmp/spark.tar.gz

ENV SPARK_HOME="/opt/spark-2.0.1-bin-hadoop2.7"

WORKDIR $SPARK_HOME
ENV PATH $SPARK_HOME/bin:$PATH

ADD spark-entrypoint.sh /
ADD spark-historyserver.sh /
ADD spark-master.sh /
ADD spark-slave.sh /

RUN chmod a+x \
    /spark-entrypoint.sh \
    /spark-historyserver.sh \
    /spark-master.sh \
    /spark-slave.sh

RUN echo "export SPARK_DIST_CLASSPATH=$(hadoop classpath)" >> $SPARK_HOME/conf/spark-env.sh

ENTRYPOINT ["/spark-entrypoint.sh"]

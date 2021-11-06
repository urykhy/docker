FROM urykhy/hadoop

ENV SPARK_HOME="/opt/spark"
ENV SPARK_URL https://archive.apache.org/dist/spark/spark-3.2.0/spark-3.2.0-bin-without-hadoop.tgz

RUN    set -x                                                           \
    && mkdir -p $SPARK_HOME                                             \
    && curl -fSL "$SPARK_URL" -o /tmp/spark.tar.gz                      \
    && tar -xf /tmp/spark.tar.gz -C $SPARK_HOME --strip-components 1    \
    && rm /tmp/spark.tar.gz

ENV PATH            $SPARK_HOME/bin:$PATH
ENV LD_LIBRARY_PATH $HADOOP_HOME/lib/native

ADD spark-defaults.conf     $SPARK_HOME/conf/spark-defaults.conf

RUN echo "export SPARK_DIST_CLASSPATH=$(hadoop classpath)" >> $SPARK_HOME/conf/spark-env.sh

WORKDIR  $SPARK_HOME
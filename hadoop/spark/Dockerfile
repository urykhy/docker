FROM urykhy/hadoop

ARG S_PROXY

ENV SPARK_HOME="/opt/spark"
ENV SPARK_URL http://archive.apache.org/dist/spark/spark-3.2.0/spark-3.2.0-bin-without-hadoop.tgz

RUN set -x                                                            \
 && mkdir -p $SPARK_HOME                                              \
 && http_proxy=${S_PROXY} curl -fSL "$SPARK_URL" -o /tmp/spark.tar.gz \
 && tar -xf /tmp/spark.tar.gz -C $SPARK_HOME --strip-components 1     \
 && rm /tmp/spark.tar.gz

ENV PATH                $SPARK_HOME/bin:$PATH
ADD spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf

RUN echo "export SPARK_DIST_CLASSPATH=$(hadoop classpath)" >> $SPARK_HOME/conf/spark-env.sh

WORKDIR  $SPARK_HOME

RUN if [ "$WITH_KERBEROS" != "true" ]; then sed -i '/KERBEROS BEGIN/,/KERBEROS END/d' $SPARK_HOME/conf/spark-defaults.conf; fi

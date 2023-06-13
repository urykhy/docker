FROM urykhy/hadoop-spark

ARG S_PROXY
ARG APT_PROXY
ARG PIP_INDEX_URL
ARG PIP_TRUSTED_HOST

# python
RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN echo "deb http://deb.debian.org/debian testing main non-free contrib" >> /etc/apt/sources.list.d/docker.list \
 && apt-get update                                                                                               \
 && apt-get -y --no-install-recommends install python3-pip python3-setuptools curl \
 && rm rm -rf /var/lib/apt/lists/* /usr/lib/python3.11/EXTERNALLY-MANAGED

# jupyter
RUN pip3 install jupyter toree \
 && jupyter toree install --spark_home=$SPARK_HOME --spark_opts='--master=local[4]' \
 && jupyter kernelspec list    \
 && rm -rf /root/.cache

# jars
RUN curl -x $S_PROXY -fSL http://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.31/mysql-connector-j-8.0.31.jar -o $SPARK_HOME/jars/mysql-connector-j-8.0.31.jar
RUN curl -x $S_PROXY -fSL http://repo1.maven.org/maven2/com/github/housepower/clickhouse-spark-runtime-3.2_2.12/0.5.0/clickhouse-spark-runtime-3.2_2.12-0.5.0.jar -o $SPARK_HOME/jars/clickhouse-spark-runtime-3.2_2.12-0.5.0.jar
RUN curl -x $S_PROXY -fSL http://repo1.maven.org/maven2/com/clickhouse/clickhouse-jdbc/0.3.2-patch11/clickhouse-jdbc-0.3.2-patch11-all.jar -o $SPARK_HOME/jars/clickhouse-jdbc-0.3.2-patch11-all.jar

# last steps
ADD spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf
RUN rm -rf /etc/hadoop/ && mkdir /work
WORKDIR /work

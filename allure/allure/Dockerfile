FROM debian:bullseye

ARG APT_PROXY

ENV ALLURE_VER 2.19.0
ENV ALLURE_URL https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/$ALLURE_VER/allure-commandline-$ALLURE_VER.tgz

RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN    apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       openjdk-11-jre-headless \
       curl procps less \
    && rm -rf /var/lib/apt/lists/*
RUN curl "$ALLURE_URL" | tar -zxf - -C /root
RUN ln -sf /root/allure-$ALLURE_VER/bin/allure /usr/bin/allure

ADD allure-update.sh /usr/bin/
ENTRYPOINT ["/usr/bin/allure-update.sh"]

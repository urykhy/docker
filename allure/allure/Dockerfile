FROM debian:buster

ENV ALLURE_VER 2.12.1
ENV ALLURE_URL http://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/$ALLURE_VER/allure-commandline-$ALLURE_VER.tgz

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       openjdk-11-jre-headless \
       curl procps less \
    && rm -rf /var/lib/apt/lists/*
RUN curl "$ALLURE_URL" | tar -zxf - -C /root
RUN ln -sf /root/allure-$ALLURE_VER/bin/allure /usr/bin/allure

ADD allure-update.sh /usr/bin/
ENTRYPOINT ["/usr/bin/allure-update.sh"]

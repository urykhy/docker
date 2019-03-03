# vim:set ft=dockerfile:
FROM openjdk:9-jre

ENV USER=root
ENV VERSION 0.6.8
ENV URL http://apache-mirror.rbc.ru/pub/apache/helix/$VERSION/binaries/helix-admin-webapp-$VERSION-pkg.tar
EXPOSE 8080

RUN    cd /tmp                                               \
    && wget $URL                                             \
    && tar -xf helix-admin-webapp-$VERSION-pkg.tar -C /opt   \
    && rm helix-admin-webapp-$VERSION-pkg.tar                \
    && ln -sT /opt/helix-admin-webapp-$VERSION /opt/helix

CMD /opt/helix/bin/run-rest-admin.sh --zkSvr $ZOOKEEPER:2181 --port 8080

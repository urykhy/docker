# vim:set ft=dockerfile:
FROM openjdk:9-jre

ENV USER=root
ENV VERSION 0.6.8
ENV URL http://apache-mirror.rbc.ru/pub/apache/helix/$VERSION/binaries/helix-core-$VERSION-pkg.tar

RUN    cd /tmp                                      \
    && wget $URL                                    \
    && tar -xf helix-core-$VERSION-pkg.tar -C /opt  \
    && rm helix-core-$VERSION-pkg.tar               \
    && ln -sT /opt/helix-core-$VERSION /opt/helix

CMD /opt/helix/bin/helix-admin.sh --zkSvr $ZOOKEEPER:2181 --addCluster MYCLUSTER && /opt/helix/bin/run-helix-controller.sh --zkSvr $ZOOKEEPER:2181 --cluster $CLUSTER


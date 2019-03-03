FROM debian:jessie-backports

RUN sed -ie 's|httpredir.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y curl apt-transport-https \
    && curl 'https://download.ceph.com/keys/release.asc' | apt-key add - \
    && echo "deb https://download.ceph.com/debian-kraken/ jessie main" > /etc/apt/sources.list.d/ceph.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ceph ceph-mds ceph-fuse radosgw \
    && rm -rf /var/lib/apt/lists/*

ENV USER=root
ADD ceph.conf /etc/ceph/ceph.conf
ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

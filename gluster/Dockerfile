FROM debian:jessie-backports

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y apt-transport-https \
    && echo "deb [trusted=yes] http://download.gluster.org/pub/gluster/glusterfs/LATEST/Debian/jessie/apt jessie main" > /etc/apt/sources.list.d/gluster.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y glusterfs-server glusterfs-client \
    && rm -rf /var/lib/apt/lists/*

ENV USER=root
ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
CMD ["glusterd", "--no-daemon", "--log-file=/dev/stdout"]
ENTRYPOINT ["/entrypoint.sh"]

FROM debian:buster

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       syncthing \
    && rm -rf /var/lib/apt/lists/*

ENV USER=ury
ENV HOME=/home/ury
CMD ["/usr/bin/syncthing"]

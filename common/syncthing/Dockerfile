FROM debian:buster

ENV VERSION v1.4.2
ENV UA "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.90 Safari/537.36"

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
       wget \
    && rm -rf /var/lib/apt/lists/*
RUN    cd   /tmp \
    && wget -k https://github.com/syncthing/syncthing/releases/download/$VERSION/syncthing-linux-amd64-$VERSION.tar.gz --user-agent "$UA" \
    && tar  -zxf syncthing-linux-amd64-$VERSION.tar.gz \
    && cp   syncthing-linux-amd64-$VERSION/syncthing /usr/bin/syncthing \
    && rm   -rf syncthing-linux-amd64-$VERSION syncthing-linux-amd64-$VERSION.tar.gz

ENV USER=ury
ENV HOME=/home/ury
CMD ["/usr/bin/syncthing"]

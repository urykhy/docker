FROM debian:11

ARG APT_PROXY

ENV DEB_URL=http://repo.percona.com/apt/pool/main/p/percona-xtrabackup-80/percona-xtrabackup-80_8.0.35-30-1.bullseye_amd64.deb

RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN    apt-get update                                  \
    && apt-get install -y --no-install-recommends wget rsync libprocps8 libssl1.1 \
    && http_proxy=${APT_PROXY} wget ${DEB_URL} -O /tmp/xtrabackup.deb \
    && apt install -y /tmp/xtrabackup.deb              \
    && apt-get remove -y wget                          \
    && apt autoremove -y                               \
    && rm /tmp/xtrabackup.deb                          \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data

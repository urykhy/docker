FROM debian:11

ENV VERSION percona-xtrabackup-80_8.0.28-21-1

RUN    apt-get update                                  \
    && apt-get install -y --no-install-recommends wget rsync \
    && wget --no-check-certificate https://repo.percona.com/apt/pool/main/p/percona-xtrabackup-80/${VERSION}.buster_amd64.deb -O /tmp/xtrabackup.deb \
    && apt install -y /tmp/xtrabackup.deb              \
    && apt-get remove -y wget                          \
    && apt autoremove -y                               \
    && rm /tmp/xtrabackup.deb                          \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /data

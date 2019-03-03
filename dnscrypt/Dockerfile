FROM alpine:latest

ARG DNSCRYPT_VERSION=master
ARG DNSCRYPT_URL=https://github.com/jedisct1//dnscrypt-wrapper/archive/master.zip
ARG DNSCRYPT_BUILDDIR=dnscrypt-wrapper-$DNSCRYPT_VERSION

ENV LISTEN_PORT     2053

RUN apk add --no-cache py-pip py-setuptools dcron coreutils bash && \
    pip install supervisor supervisor-stdout

RUN set -xe && \
    apk add --no-cache --virtual .run-deps \
                                libevent \
                                libsodium && \
    apk add --no-cache --virtual .build-deps \
                                autoconf \
                                bsd-compat-headers \
                                build-base \
                                curl \
                                libevent-dev \
                                libexecinfo-dev \
                                libsodium-dev && \

    curl -sSL $DNSCRYPT_URL > /tmp/master.zip && \
    cd tmp && unzip master.zip &&   \
    cd $DNSCRYPT_BUILDDIR &&        \
    make configure &&               \
    ./configure --prefix=/usr &&    \
    make install &&                 \
    cd .. &&                        \
    rm -rf $$DNSCRYPT_BUILDDIR &&   \
    apk del .build-deps &&          \
    mkdir -p /etc/dnscrypt-wrapper
RUN adduser -S -h /etc/dnscrypt-wrapper -s /usr/sbin/nologin -D dnscrypt-wrapper

ADD ./supervisord.conf /etc/supervisor/supervisord.conf
ADD ./refresh.sh       /etc/periodic/hourly/refresh
ADD ./start.sh         /usr/bin/start.sh

EXPOSE $LISTEN_PORT/tcp $LISTEN_PORT/udp
CMD ["/usr/bin/supervisord"]

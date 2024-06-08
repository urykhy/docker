FROM debian:bookworm AS builder
ARG APT_PROXY
RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN apt update                                                \
 && apt install -y --no-install-recommends git build-essential pcaputils libpcap-dev ca-certificates \
 && cd /tmp                                                   \
 && git clone --depth 1 https://github.com/GNS3/ubridge.git   \
 && cd ubridge                                                \
 && make

FROM debian:bookworm
ARG APT_PROXY
ARG PIP_INDEX_URL
ARG PIP_TRUSTED_HOST

RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN echo "Types: deb\nURIs: http://deb.debian.org/debian\nSuites: bookworm\nComponents: non-free\nSigned-By: /usr/share/keyrings/debian-archive-keyring.gpg" > /etc/apt/sources.list.d/docker.sources

RUN apt update                   \
 && apt -y install eatmydata     \
 && eatmydata apt install        \
    -y                           \
    --no-install-recommends      \
    procps                       \
    python3 python3-pip pipx python3-pyqt5 python3-pyqt5.qtwebsockets  \
    python3-pyqt5.qtsvg dynamips curl gnupg2 telnet xterm libcap2-bin  \
 && rm -rf /var/lib/apt/lists/*

COPY --from=builder /tmp/ubridge/ubridge /usr/bin/
RUN setcap cap_net_admin,cap_net_raw=ep /usr/bin/ubridge

RUN adduser -uid 1000 user
USER user
RUN pip install --break-system-packages --no-cache-dir gns3-server gns3-gui

ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb
ENV PATH=$PATH:/home/user/.local/bin/
CMD ["gns3"]

# Based on https://github.com/mdouchement/docker-zoom-us
FROM debian:bookworm
ENV DEBIAN_FRONTEND noninteractive
ARG APT_PROXY="http://elf.dark:8081"
RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy

RUN echo "deb http://mirror.yandex.ru/debian bookworm main non-free contrib" > /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -qy --no-install-recommends curl ca-certificates \
            sudo desktop-file-utils lib32z1 \
            libx11-6 libegl1-mesa libxcb-shm0 \
            libglib2.0-0 libgl1-mesa-glx libxrender1 libxcomposite1 libxslt1.1 \
            libgstreamer1.0-0 libgstreamer-plugins-base1.0-0 libxi6 libsm6 \
            libfontconfig1 libpulse0 libsqlite3-0 \
            libxcb-shape0 libxcb-xfixes0 libxcb-randr0 libxcb-image0 \
            libxcb-keysyms1 libxcb-xtest0 ibus ibus-gtk \
            libxcb-xinerama0 libxkbcommon-x11-0 \
            libxcb-cursor0 libxcb-icccm4 \
            libnss3 libxss1 pulseaudio strace procps less mesa-utils glx-alternative-nvidia \
 && apt-get clean -y \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

ARG ZOOM_URL=https://zoom.us/client/latest/zoom_amd64.deb
RUN curl -sSL $ZOOM_URL -o /tmp/zoom_setup.deb \
 && dpkg -i /tmp/zoom_setup.deb \
 && apt-get -f install          \
 && rm -rf /var/lib/apt/lists/* \
 && rm /tmp/zoom_setup.deb

RUN adduser --uid 1000 user
USER user
WORKDIR /home/user

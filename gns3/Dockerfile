# vim:set ft=dockerfile:
FROM alpine:3.12

RUN apk update \
 && apk add --no-cache \
        python3 py3-pip mesa-dri-intel gns3-gui gns3-server \
        ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family xterm busybox-extras ubridge
RUN pip3 install --no-cache-dir 'typing>=3.5.3.0' 'aiohttp-cors==0.7.0' 'Jinja2>=2.7.3' 'raven>=5.23.0' 'psutil>=3.0.0' 'zipstream>=1.1.4' 'jsonschema>=2.4.0'
RUN adduser -D -u 1000 user
USER user
ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb
VOLUME /home/user
CMD ["/usr/bin/gns3"]

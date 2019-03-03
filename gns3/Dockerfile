# vim:set ft=dockerfile:
FROM alpine:latest

RUN apk update && apk add mesa-dri-intel gns3-gui gns3-server
RUN apk add ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family xterm
RUN pip3 install 'typing>=3.5.3.0'        && \
    pip3 install 'aiohttp>=1.3.5,<=1.4.0' && \
    pip3 install 'aiohttp-cors==0.5.1'    && \
    pip3 install 'yarl>=0.9.8,<0.10'      && \
    pip3 install 'Jinja2>=2.7.3'          && \
    pip3 install 'raven>=5.23.0'          && \
    pip3 install 'psutil>=3.0.0'          && \
    pip3 install 'zipstream>=1.1.4'       && \
    pip3 install 'jsonschema>=2.4.0'
RUN adduser -D -u 1000 user
USER user
ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb
VOLUME /home/user
CMD ["/usr/bin/gns3"]

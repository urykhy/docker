# vim:set ft=dockerfile:
FROM debian:buster

RUN    apt-get update              \
    && apt-get install -y  --no-install-recommends quagga-ospfd supervisor python-pip python-setuptools python-wheel \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /run/quagga           \
    && chown quagga: /run/quagga

ADD ./ospfd.conf /etc/quagga/ospfd.conf
ADD ./zebra.conf /etc/quagga/zebra.conf
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chown quagga: /etc/quagga/*

EXPOSE 2601 2604
ENV USER=root
CMD ["/usr/bin/supervisord"]

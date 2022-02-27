FROM golang:1.17-stretch AS forego
RUN go install github.com/ddollar/forego@master

FROM debian:buster

RUN    apt-get update              \
    && apt-get install -y  --no-install-recommends quagga-ospfd \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /run/quagga           \
    && chown quagga: /run/quagga

ADD ./ospfd.conf /etc/quagga/ospfd.conf
ADD ./zebra.conf /etc/quagga/zebra.conf
ADD ./zebra.proc /
RUN chown quagga: /etc/quagga/*

EXPOSE 2601 2604
ENV USER=root

COPY --from=forego   /go/bin/forego /usr/bin/
CMD ["forego", "start", "-r", "-f", "/zebra.proc"]

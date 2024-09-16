FROM debian:buster

RUN apt-get update              \
 && apt-get install -y  --no-install-recommends quagga-ospfd \
 && rm -rf /var/lib/apt/lists/* \
 && sed -i 's/quagga:x:101:102/quagga:x:1000:100/' /etc/passwd \
 && mkdir /run/quagga           \
 && chown quagga: /run/quagga

EXPOSE 2601 2604
ENV USER=root
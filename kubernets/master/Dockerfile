FROM golang:1.17-stretch AS forego
RUN go install github.com/ddollar/forego@master

FROM gcr.io/google_containers/hyperkube-amd64:v1.17.0

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update                \
    && apt-get install -y  --no-install-recommends curl dnsutils dkms- \
    && curl -L https://github.com/coreos/flannel/releases/download/v0.11.0/flanneld-amd64 > /usr/bin/flanneld \
    && chmod +x /usr/bin/flanneld \
    && rm -rf /var/lib/apt/lists/*

ADD 10-flannel.conf  /etc/cni/net.d/
ADD ca.crt           /kube.ca
ADD client-kube.crt  /client.crt
ADD client-kube.key  /client.key
ADD client-kube.pub  /client.pub
ADD server-kube.crt  /server.crt
ADD server-kube.key  /server.key
ADD kubeconfig       /kubeconfig
ADD master.proc      /master.proc
ENV USER=root

RUN touch /usr/local/sbin/.profile # forego wants one
COPY --from=forego   /go/bin/forego /usr/bin/

ENTRYPOINT ["forego", "start", "-r", "-f", "/master.proc"]

FROM golang:1.17-stretch AS forego
RUN go install github.com/ddollar/forego@master

FROM gcr.io/google_containers/hyperkube-amd64:v1.17.0

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update                   \
    && apt-get install -y --no-install-recommends apt-transport-https curl dnsutils dkms- \
    && echo "deb [trusted=yes] https://download.docker.com/linux/debian stretch stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update                   \
    && apt-get install -y --no-install-recommends docker-ce=18.06.3~ce~3-0~debian  \
    && curl -L https://github.com/coreos/flannel/releases/download/v0.11.0/flanneld-amd64 > /usr/bin/flanneld \
    && chmod +x /usr/bin/flanneld \
    && rm -rf /var/lib/apt/lists/*

RUN touch /usr/local/sbin/.profile # forego wants one
COPY --from=forego   /go/bin/forego /usr/bin/

ADD 10-flannel.conf  /etc/cni/net.d/
ADD ca.crt           /kube.ca
ADD client-kube.crt  /client.crt
ADD client-kube.key  /client.key
ADD kubeconfig       /kubeconfig
ADD node.proc        /node.proc
ENV USER=root
ADD entrypoint.sh    /entrypoint.sh
ENTRYPOINT unshare -C /entrypoint.sh

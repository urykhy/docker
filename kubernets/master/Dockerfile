FROM gcr.io/google_containers/hyperkube-amd64:v1.15.0

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update                \
    && apt-get install -y  --no-install-recommends supervisor python-pip python-setuptools python-wheel curl dnsutils dkms- \
    && pip install supervisor-stdout \
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
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ENV USER=root
CMD ["/usr/bin/supervisord"]

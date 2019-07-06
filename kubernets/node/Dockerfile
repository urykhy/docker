FROM gcr.io/google_containers/hyperkube-amd64:v1.11.0

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update                   \
    && apt-get install -y --no-install-recommends supervisor python-pip python-setuptools python-wheel apt-transport-https curl dnsutils dkms- \
    && pip install supervisor-stdout    \
    && echo "deb [trusted=yes] https://download.docker.com/linux/debian stretch stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update                   \
    && apt-get install -y --no-install-recommends docker-ce \
    && curl -L https://github.com/coreos/flannel/releases/download/v0.11.0/flanneld-amd64 > /usr/bin/flanneld \
    && chmod +x /usr/bin/flanneld \
    && rm -rf /var/lib/apt/lists/*

ENV USER=root

ADD kubeconfig       /kubeconfig
ADD net-conf.json    /etc/kube-flannel/net-conf.json
ADD 10-flannel.conf  /etc/cni/net.d/
ADD entrypoint.sh    /entrypoint.sh
ADD ca.crt           /kube.ca
ADD client-kube.crt  /client.crt
ADD client-kube.key  /client.key
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/entrypoint.sh"]

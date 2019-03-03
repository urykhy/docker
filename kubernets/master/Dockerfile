FROM gcr.io/google_containers/hyperkube-amd64:v1.11.0

RUN    sed -ie 's|deb.debian.org|mirror.yandex.ru|' /etc/apt/sources.list \
    && apt-get update                \
    && apt-get install -y  --no-install-recommends supervisor python-pip python-setuptools python-wheel curl dnsutils dkms- \
    && pip install supervisor-stdout \
    && rm -rf /var/lib/apt/lists/*

ADD ca.crt          /kube.ca
ADD client-kube.key /client.key
ADD client-kube.pub /client.pub
ADD server-kube.crt /server.crt
ADD server-kube.key /server.key
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ENV USER=root
CMD ["/usr/bin/supervisord"]

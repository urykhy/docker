FROM debian:11

ENV ORC_VERSION=3.2.6
ENV ORC_URL=https://github.com/openark/orchestrator/releases/download/v${ORC_VERSION}/orchestrator_${ORC_VERSION}_amd64.deb

RUN    apt-get update                                  \
    && apt-get install --no-install-recommends -y ca-certificates curl jq \
    && curl -fSL "$ORC_URL" -o /tmp/orc.deb            \
    && dpkg -i /tmp/orc.deb                            \
    && rm -rf /tmp/orc.deb                             \
    && rm -rf /var/lib/apt/lists/*

ADD orchestrator.json /etc/

WORKDIR /usr/local/orchestrator
CMD ["/usr/local/orchestrator/orchestrator", "-config", "/etc/orchestrator.json", "http"]

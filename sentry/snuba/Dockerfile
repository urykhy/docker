FROM getsentry/snuba:23.1.1

USER root
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends curl
RUN curl -fSL https://github.com/F1bonacc1/process-compose/releases/download/v1.46.0/process-compose_linux_amd64.tar.gz -o - | tar -C /bin/ -vzxf - process-compose

ADD process-compose.yaml /
ENTRYPOINT []
CMD []
USER snuba
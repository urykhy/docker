FROM nextcloud:30

ARG APT_PROXY

RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN apt-get update && apt-get -y --no-install-recommends install smbclient

ADD cron.sh /bin/

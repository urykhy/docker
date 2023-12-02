FROM debian:12
ARG APT_PROXY

RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN    apt-get update               \
    && apt-get install              \
       -y                           \
       --no-install-recommends      \
       make gcc g++ libc6-dev       \
       ruby-dev ruby                \
    && rm -rf /var/lib/apt/lists/*
RUN gem install youplot
FROM jenkins/jenkins:2.425-jdk11

USER root

ARG APT_PROXY
RUN echo "Acquire::http::Proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf.d/02proxy
RUN    apt-get update               \
    && apt-get install              \
       -y                           \
       --no-install-recommends      \
       wget                         \
       docker.io                    \
    && rm -rf /var/lib/apt/lists/*

RUN sed -e 's/docker.*/docker:x:999:jenkins/' -i /etc/group

USER jenkins

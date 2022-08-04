FROM jenkinsci/blueocean

USER root
RUN sed -e 's/docker.*/docker:x:999:jenkins/' -i /etc/group
USER jenkins

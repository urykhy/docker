FROM golang:1.17-stretch AS forego
RUN go install github.com/ddollar/forego@master

FROM debian:11

RUN    apt-get update               \
    && apt-get install              \
       -y                           \
       --no-install-recommends      \
       krb5-admin-server            \
       krb5-kdc                     \
    && rm -rf /var/lib/apt/lists/*

ADD kadm5.acl /etc/krb5kdc/
ADD kdc.conf  /etc/krb5kdc/
ADD krb5.conf /etc/

EXPOSE 88 464 749
ENV USER=root
ADD entrypoint.sh /
ADD kerberos.proc /

COPY --from=forego   /go/bin/forego /usr/bin/

ENTRYPOINT ["/entrypoint.sh"]

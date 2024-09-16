FROM debian:11

RUN apt-get update               \
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

ENTRYPOINT ["/entrypoint.sh"]

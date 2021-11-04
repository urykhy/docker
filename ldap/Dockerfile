# vim:set ft=dockerfile:
FROM debian:11

ADD debconf /tmp/debconf
RUN DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true debconf-set-selections /tmp/debconf

RUN    apt-get update               \
    && apt-get install              \
       -y                           \
       --no-install-recommends      \
       slapd                        \
       ldap-utils                   \
    && rm -rf /var/lib/apt/lists/*  \
       mkdir /etc/ldap/ssl

ADD ca.crt                   /etc/ldap/ssl/ca.crt
ADD server-ldap.elf.dark.crt /etc/ldap/ssl/server.crt
ADD server-ldap.elf.dark.key /etc/ldap/ssl/server.key

ADD init-tree.ldif           /tmp/
ADD tls.ldif                 /tmp/
ADD add-user-foo.ldif        /tmp/
ADD add-user-bar.ldif        /tmp/

EXPOSE 389 636
ENV USER=root
ADD entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

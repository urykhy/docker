#!/bin/bash

set -xe

if [ ! -f /var/lib/ldap/INIT ]; then
    echo 'prepare ... '
    slapadd -v -l /tmp/init-tree.ldif
    for x in /tmp/add-user* ; do
        slapadd -l $x
    done
    mv /etc/ldap/slapd.d /var/lib/ldap/
    touch /var/lib/ldap/INIT
fi

exec /usr/sbin/slapd -4 -d 0 -h 'ldap:/// ldapi:/// ldaps:///' -F /var/lib/ldap/slapd.d

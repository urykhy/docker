#!/bin/bash

set -xe

if [ ! -f /var/lib/krb5kdc/principal.ok ]; then
    echo 'prepare ... '
    kdb5_util -P kerberos create -s
    echo -e 'admin\nadmin'   | kadmin.local -q "addprinc admin/admin"
    echo -e 'ury\nury'       | kadmin.local -q "addprinc ury"
    echo -e 'root\nroot'     | kadmin.local -q "addprinc root"
    echo -e 'user\nuser'     | kadmin.local -q "addprinc user"
    echo -e 'hadoop\nhadoop' | kadmin.local -q "addprinc hadoop/admin"
fi

exec /usr/sbin/krb5kdc -P /var/run/krb5kdc.pid -n
#!/bin/bash

cd /etc/dnscrypt-wrapper
OLD=`ls ?.key -t1 | tail -n 1`
echo "oldest cert is $OLD"
OLD="${OLD%.*}"

rm $OLD.key $OLD.cert
/usr/sbin/dnscrypt-wrapper --gen-crypt-keypair --crypt-secretkey-file=$OLD.key
/usr/sbin/dnscrypt-wrapper --gen-cert-file     --crypt-secretkey-file=$OLD.key --provider-cert-file=$OLD.cert \
                                               --provider-publickey-file=public.key --provider-secretkey-file=private.key \
                                               --cert-file-expire-days=1
killall dnscrypt-wrapper || true # must be auto started by supervisord

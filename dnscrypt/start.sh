#! /bin/bash

RUNTIME_OPTS="--user=dnscrypt-wrapper --pidfile=/var/run/dnscrypt-wrapper.pid"
KEY_OPTS="--provider-publickey-file=public.key --provider-secretkey-file=private.key --provider-name=2.dnscrypt-cert"
NETWORK_OPTS="--listen-address=10.103.10.3:2053 --resolver-address=8.8.4.4 --ext-address=10.103.10.3:2053 --dnssec --nolog"

test -f "private.key" -a -f "public.key" || /usr/sbin/dnscrypt-wrapper --gen-provider-keypair $KEY_OPTS $NETWORK_OPTS

for x in 0 1 2; do
    if [ ! -f $x.key ]; then
        /usr/sbin/dnscrypt-wrapper --gen-crypt-keypair --crypt-secretkey-file=$x.key
        /usr/sbin/dnscrypt-wrapper --gen-cert-file     --crypt-secretkey-file=$x.key --provider-cert-file=$x.cert \
                                                       --provider-publickey-file=public.key --provider-secretkey-file=private.key \
                                                       --cert-file-expire-days=1
        sleep 5
    fi
done

# sort keys by time
KNAMES=`ls -1tr ?.key | xargs | sed -e 's/ /,/g'`
CNAMES=`ls -1tr ?.cert | xargs | sed -e 's/ /,/g'`
KEY_OPTS="$KEY_OPTS --crypt-secretkey-file=$KNAMES --provider-cert-file=$CNAMES"

echo "starting wrapper"
/usr/sbin/dnscrypt-wrapper --show-provider-publickey
exec /usr/sbin/dnscrypt-wrapper $RUNTIME_OPTS $KEY_OPTS $NETWORK_OPTS

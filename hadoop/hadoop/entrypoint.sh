#!/bin/bash

# fix broken docker dns
cat <<EOF > /etc/resolv.conf
domain hadoop.docker
nameserver 10.103.10.3
EOF

exec "$@"

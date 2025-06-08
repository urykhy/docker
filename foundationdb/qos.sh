#!/bin/bash

case "$1" in
    install)
        docker compose exec -T coordinator bash << 'EOF'
sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/CentOS-*.repo
sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/CentOS-*.repo
sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/CentOS-*.repo
yum install -y iptables iproute
EOF
    ;;
    start)
        docker compose exec -T coordinator bash << 'EOF'
ADDR=`hostname -I | xargs`
tc qdisc del dev lo root handle 1:
tc qdisc add dev lo root handle 1: htb default 10
tc class add dev lo parent 1:  classid 1:1  htb rate 5000mbit cburst 65535
tc class add dev lo parent 1:1 classid 1:10 htb rate 4990mbit cburst 65535
tc class add dev lo parent 1:1 classid 1:20 htb rate   10mbit cburst 65535
tc qdisc add dev lo parent 1:10 handle 10: sfq perturb 10
tc qdisc add dev lo parent 1:20 handle 20: sfq perturb 10

tc filter add dev lo protocol ip parent 1: prio 1 u32 match ip src ${ADDR}/32 match ip dport 4530 0xffff flowid 1:20
tc filter add dev lo protocol ip parent 1: prio 1 u32 match ip src ${ADDR}/32 match ip dport 4531 0xffff flowid 1:20
tc filter add dev lo protocol ip parent 1: prio 1 u32 match ip src ${ADDR}/32 match ip dport 4532 0xffff flowid 1:20
tc filter add dev lo protocol ip parent 1: prio 1 u32 match ip src ${ADDR}/32 match ip dport 4533 0xffff flowid 1:20
tc filter add dev lo protocol ip parent 1: prio 1 u32 match ip src ${ADDR}/32 match ip dport 4534 0xffff flowid 1:20
tc filter add dev lo protocol ip parent 1: prio 1 u32 match ip src ${ADDR}/32 match ip sport 4520 0xffff flowid 1:20
tc filter add dev lo protocol ip parent 1: prio 1 u32 match ip src ${ADDR}/32 match ip sport 4521 0xffff flowid 1:20
tc filter add dev lo protocol ip parent 1: prio 1 u32 match ip src ${ADDR}/32 match ip sport 4522 0xffff flowid 1:20
tc filter add dev lo protocol ip parent 1: prio 1 u32 match ip src ${ADDR}/32 match ip sport 4523 0xffff flowid 1:20
tc filter add dev lo protocol ip parent 1: prio 1 u32 match ip src ${ADDR}/32 match ip sport 4524 0xffff flowid 1:20
EOF
    ;;
    stop)
        docker compose exec -T coordinator bash << 'EOF'
tc qdisc del dev lo root handle 1:
EOF
    ;;
    status)
        docker compose exec -T coordinator bash << 'EOF'
tc -s class show dev lo
tc -s qdisc show dev lo
tc -s filter show dev lo
EOF
    ;;
    *)
        echo "Usage: $0 {install|start|stop|status}"
        exit 1
    ;;
esac

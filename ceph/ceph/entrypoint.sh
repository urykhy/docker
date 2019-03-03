#!/bin/bash


CEPH_MON_IP=`getent hosts mon | awk '{ print $1 }' | head -n 1`

echo "* configuring fs uuid $CEPH_FSID"
sed -i "s/%CEPH_FSID%/$CEPH_FSID/" /etc/ceph/ceph.conf
echo "* configuring mon at $CEPH_MON_IP"
sed -i "s/%CEPH_MON_IP%/$CEPH_MON_IP/" /etc/ceph/ceph.conf

if [ -n "$OSD" ]; then
    CEPH_HOME=/var/lib/ceph/osd
    ID=`find $CEPH_HOME/ceph-*/ -maxdepth 0 -type d 2>/dev/null | sed -ne 's/.*-\([[:digit:]]\+\).*/\1/p'`
    if [ ! -f $CEPH_HOME/ceph-$ID/ready ];
    then
        echo "* preparing new osd"
        HOST=`hostname -s`
        ID=`ceph osd create`
        mkdir -p $CEPH_HOME/ceph-$ID
        ceph-osd -i $ID --mkfs
        ceph osd crush add-bucket $HOST host
        ceph osd crush move $HOST root=default
        ceph osd crush add osd.$ID 1.0 host=$HOST
    else
        echo "* found osd data directory for id $ID"
    fi
    exec ceph-osd -i $ID -d --debug_osd 0
fi

if [ -n "$MON" ]; then
    CEPH_HOME=/var/lib/ceph/mon
    if [ ! -f $CEPH_HOME/ceph-$MON/done ];
    then
        echo "* preparing new mon"
        monmaptool --create --add $MON $CEPH_MON_IP:6789 --fsid $CEPH_FSID /tmp/monmap
        monmaptool --print /tmp/monmap
        mkdir -p $CEPH_HOME/ceph-$MON/
        ceph-mon --mkfs -i a --monmap /tmp/monmap
        touch $CEPH_HOME/ceph-$MON/done
    fi
    exec ceph-mon -i $MON -d --debug_mon 0
fi

if [ -n "$MDS" ]; then
    CEPH_HOME=/var/lib/ceph/mds
    mkdir -p $CEPH_HOME/ceph-$MDS || true
    exec ceph-mds -i $MDS -d -m mon:6789 --debug_mds 1
fi

if [ -n "$RGW" ]; then
    exec radosgw -n client.$RGW -d --debug_rgw 0
fi

exec $@

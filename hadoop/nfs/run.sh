#!/bin/bash

$HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR portmap &
pid1="$!"

$HADOOP_PREFIX/bin/hdfs --config $HADOOP_CONF_DIR nfs3 &
pid2="$!"

trap 'kill $pid1 $pid2' SIGTERM
wait

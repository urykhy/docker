#!/bin/bash

datadir=`echo $HDFS_CONF_dfs_datanode_data_dir | perl -pe 's#file://##'`
if [ ! -d $datadir ]; then
  echo "Datanode data directory not found: $dataedir"
  exit 2
fi

yarn --config $HADOOP_CONF_DIR nodemanager &
exec hdfs --config $HADOOP_CONF_DIR datanode

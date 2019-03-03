#!/bin/sh

for i in hadoop namenode datanode resourcemanager nodemanager historyserver nfs spark spark-notebook; do
    ( cd $i && ./build.sh)
done

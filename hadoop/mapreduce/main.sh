#!/bin/bash

set -x

if [ "$WITH_KERBEROS" == "true" ]; then
    echo root | kinit root
fi

hadoop fs -rm -r /root/task-input
hadoop fs -rm -r /root/task-output

hadoop fs -mkdir -p /root/task-input
hadoop fs -put      /task/*.txt /root/task-input/
hadoop fs -ls       /root/task-input

hadoop jar /opt/hadoop-*/share/hadoop/tools/lib/hadoop-streaming-*.jar \
    -Dmapreduce.map.output.compress=true \
    -Dmapreduce.map.output.compress.codec=org.apache.hadoop.io.compress.Lz4Codec \
    -Dmapreduce.output.fileoutputformat.compress=true \
    -Dmapreduce.output.fileoutputformat.compress.codec=org.apache.hadoop.io.compress.ZStandardCodec \
    -Dmapreduce.output.fileoutputformat.compress.type=Block \
    -file     /task/mapper.py    \
    -mapper   /task/mapper.py    \
    -file     /task/reducer.py   \
    -combiner /task/reducer.py   \
    -reducer  /task/reducer.py   \
    -input    /root/task-input/* \
    -output   /root/task-output

hadoop fs -get /root/task-output/* /task/result/

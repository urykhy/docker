#!/bin/bash

set -x

if [ "$WITH_KERBEROS" == "true" ]; then
    echo root | kinit root
fi

hdfs dfs -rm -r /user/root/spark-result.txt

spark-shell < /task/main.scala

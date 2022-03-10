#!/bin/bash

D="hadoop.docker"
rm /tmp/keytab || true
for x in namenode datanode1 datanode2 kms resourcemanager historyserver spark;
do
    echo -e "hadoop\ndelprinc hdfs/$x.$D\nyes" | kadmin -p hadoop/admin
    echo -e "hadoop\ndelprinc HTTP/$x.$D\nyes" | kadmin -p hadoop/admin
    echo -e "hadoop\naddprinc -randkey hdfs/$x.$D\naddprinc -randkey HTTP/$x.$D\n" | kadmin -p hadoop/admin
    echo -e "hadoop\nktadd -k /tmp/keytab hdfs/$x.$D HTTP/$x.$D\n" | kadmin -p hadoop/admin
done
file /tmp/keytab
klist -e -k -t /tmp/keytab
mv /tmp/keytab hadoop/kerberos.keytab

# minio (export user)
echo -e "hadoop\ndelprinc minio\nyes" | kadmin -p hadoop/admin
echo -e "hadoop\naddprinc -randkey minio\n" | kadmin -p hadoop/admin
echo -e "hadoop\nktadd -k /tmp/keytab minio\n" | kadmin -p hadoop/admin
mv /tmp/keytab hadoop/minio.keytab

#!/bin/sh

exec spark-class org.apache.spark.deploy.master.Master $@

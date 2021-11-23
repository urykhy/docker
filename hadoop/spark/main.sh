#!/bin/bash

set -x
echo root | kinit root
spark-shell < /task/main.scala

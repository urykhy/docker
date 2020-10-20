#!/bin/sh

for i in hadoop namenode; do
    ( cd $i && ./build.sh)
done

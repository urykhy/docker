#!/bin/sh

for i in hadoop spark; do
    ( cd $i && ./build.sh)
done

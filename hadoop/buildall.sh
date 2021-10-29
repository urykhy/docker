#!/bin/sh

for i in hadoop; do
    ( cd $i && ./build.sh)
done

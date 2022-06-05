#!/bin/bash

for i in common mgt data sql; do
    ( cd $i && ./build.sh)
done


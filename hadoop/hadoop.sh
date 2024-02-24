#!/bin/bash

exec docker run --rm -it -v `pwd`:/data --workdir=/data --name "hadoop-cli" --hostname "hadoop-cli" urykhy/hadoop hadoop "$@"

#!/bin/bash

#dbt debug
#dbt run

exec docker run \
     --rm -it --name "dbt" \
     --mount type=bind,source=`pwd`/project,target=/home/user \
     --mount type=bind,source=`pwd`/profiles.yml,target=/home/user/.dbt/profiles.yml \
     --hostname "dbt" urykhy/dbt dbt "$@"

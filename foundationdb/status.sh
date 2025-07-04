#!/bin/bash

fdbcli --exec "status"

(
    echo "address cpu rss roles"
    fdbcli --exec "status json" | jq -r '(.cluster.processes[] | [.address, (.cpu.usage_cores * 1000 | round / 10), .memory.rss_bytes, .roles[].role]) | @tsv' | awk '{printf "%s %2.1f %2.0f %s\n", $1, $2, $3/1048576, $4}'
) | column -t -R 2,3 | sort -n

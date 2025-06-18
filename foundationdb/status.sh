#!/bin/bash

fdbcli --exec "status"

fdbcli --exec "status json" | jq -r '["address","cpu","roles"], (.cluster.processes[] | [.address, (.cpu.usage_cores * 1000 | round / 10), .roles[].role]) | @tsv' | awk '{printf "%s %2.1f %s\n", $1, $2, $3}' | column -t -R 2 | sort -n

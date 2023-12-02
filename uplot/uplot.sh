#!/bin/bash

exec docker run --rm -i --name "uplot" --hostname "uplot" urykhy/uplot uplot "$@"
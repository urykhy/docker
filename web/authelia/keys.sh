#!/bin/bash

echo "keys"
openssl genrsa -out private.pem 2048
openssl rsa -in private.pem -outform PEM -pubout -out public.pem
cat private.pem
cat public.pem
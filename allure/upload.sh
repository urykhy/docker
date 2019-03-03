#!/bin/bash

curl -T $1 http://web.allure/upload/`basename $1`

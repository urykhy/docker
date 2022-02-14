#!/bin/bash

if [ "$WITH_KERBEROS" != "true" ]
then
    echo "strip kerberos parts from configuration files ..."
    for x in /etc/hadoop/*.xml;
    do
        sed -i '/KERBEROS BEGIN/,/KERBEROS END/d' $x
    done
fi

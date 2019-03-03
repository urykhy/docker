#!/bin/bash

NOW=`date +%s`
for i in `seq 1 1000`; do
    echo -n '('$((NOW+$i*600))','$((RANDOM%128))','$RANDOM'),' >> DATA
done
echo -n '('$((NOW))','$((RANDOM%128))','$RANDOM')' >> DATA

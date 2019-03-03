#!/bin/bash

LISTENER_NAME=LISTENER

. /etc/sysconfig/oracle-xe-18c.conf

LSNR=$ORACLE_HOME/bin/lsnrctl
SQLPLUS=$ORACLE_HOME/bin/sqlplus

DONE=0
trap 'DONE=1;' SIGTERM

echo "Starting Oracle Net Listener."
$LSNR start $LISTENER_NAME

echo "Starting Oracle Database instance $ORACLE_SID."
$SQLPLUS -s /nolog << EOF
connect / as sysdba
startup
alter pluggable database all open
exit;
EOF
echo "Oracle Database instance $ORACLE_SID started."

while [ "$DONE" -eq "0" ]
do
    sleep 1
done

echo "Shutting down Oracle Database instance $ORACLE_SID."
$SQLPLUS -s /nolog << EOF
connect / as sysdba
shutdown immediate
exit;
EOF
echo "Oracle Database instance $ORACLE_SID shut down."

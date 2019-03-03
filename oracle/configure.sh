#!/bin/bash

ORAENV_ASK=1
ORACLE_PASSWORD="oracle"
ORACLE_HOME_NAME="OraHomeXE"
LISTENER_NAME=LISTENER
TEMPLATE_NAME=XE_Database.dbc
CREATE_AS_CDB=true
NUMBER_OF_PDBS=1
PDB_NAME=XEPDB1
ORACLE_SID=XE
EM_EXPRESS_PORT="5500"

. /etc/sysconfig/oracle-xe-18c.conf

SQLSCRIPT_CONSTRUCT="-customScripts $ORACLE_HOME/assistants/dbca/postdb_creation.sql"
ORABASE=`$ORACLE_HOME/bin/orabase`
NETCA=$ORACLE_HOME/bin/netca
LSNR=$ORACLE_HOME/bin/lsnrctl
SQLPLUS=$ORACLE_HOME/bin/sqlplus
DBCA=$ORACLE_HOME/bin/dbca

echo "Configuring Oracle Listener."
mkdir -p $ORABASE/cfgtoollogs/netca
$NETCA /orahome $ORACLE_HOME /instype typical /inscomp client,oraclenet,javavm,server,ano /insprtcl tcp /cfg local /authadp NO_VALUE /responseFile $ORACLE_HOME/network/install/netca_typ.rsp /silent /orahnam $ORACLE_HOME_NAME /listenerparameters DEFAULT_SERVICE=XE

sed -e "s/HOST = [^)]\+/HOST = 0.0.0.0/" -i $ORACLE_HOME/network/admin/listener.ora

echo "Starting Oracle Listener."
$LSNR start $LISTENER_NAME  > /dev/null
$LSNR status $LISTENER_NAME > /dev/null

echo "Configuring Oracle Database $ORACLE_SID."

(echo '$ORACLE_PASSWORD'; echo '$ORACLE_PASSWORD'; echo '$ORACLE_PASSWORD') | $DBCA -silent -createDatabase -gdbName $ORACLE_SID -templateName $TEMPLATE_NAME -characterSet $CHARSET -createAsContainerDatabase $CREATE_AS_CDB -numberOfPDBs $NUMBER_OF_PDBS -pdbName $PDB_NAME -sid $ORACLE_SID -emConfiguration DBEXPRESS -emExpressPort $EM_EXPRESS_PORT -J-Doracle.assistants.dbca.validate.DBCredentials=false -sampleSchema true $SQLSCRIPT_CONSTRUCT $DBFILE_CONSTRUCT $MEMORY_CONSTRUCT

echo "Shutting down Oracle Database instance $ORACLE_SID."
$SQLPLUS -s /nolog << EOF
connect / as sysdba
shutdown immediate
exit;
EOF

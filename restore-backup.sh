#!/bin/bash

# Define variables
BACKUP_PATH=/var/opt/mssql/backup/gestion.bak
DATABASE_NAME=YourDatabaseName

# Restore the backup with valid paths
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "YourStrong!Passw0rd" -Q "
RESTORE DATABASE [$DATABASE_NAME]
FROM DISK = N'$BACKUP_PATH'
WITH MOVE 'gestion_vacia' TO '/var/opt/mssql/data/$DATABASE_NAME.mdf',
     MOVE 'gestion_vacia_log' TO '/var/opt/mssql/data/$DATABASE_NAME_log.ldf',
     REPLACE"

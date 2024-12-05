# mssql-docker
a dockerfile for mounting and restoring mssql databases
docker run -d --name mssql   -e "ACCEPT_EULA=Y"   -v /path/to/backup:/var/opt/mssql/backup/filenamehere -p 1433:1433  mssql

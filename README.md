# mssql-docker
a dockerfile for mounting and restoring mssql databases
docker build . -t mssql ( you need to be in the directory with the Dockerfile and restore-backup.sh file)
docker run -d --name mssql   -e "ACCEPT_EULA=Y"   -v /path/to/backup:/var/opt/mssql/backup/filenamehere -p 1433:1433  mssql
make sure you give execution permissions for the restore-backup.sh 

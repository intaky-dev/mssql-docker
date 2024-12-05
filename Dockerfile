# Use the official Microsoft SQL Server 2022 image
FROM mcr.microsoft.com/mssql/server:2022-latest

# Set the environment variables for the SQL Server
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=YourStrong!Passw0rd

# Switch to root to perform installations
USER root
# Install SQL Server tools
RUN apt-get update && apt-get install -y curl apt-transport-https gnupg2 \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools unixodbc-dev \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
    && rm -rf /var/lib/apt/lists/*

# Create the directory and copy the restore script
RUN mkdir -p /usr/src/app
COPY restore-backup.sh /usr/src/app/restore-backup.sh

# Switch back to the default mssql user
USER mssql

# Expose SQL Server default port
EXPOSE 1433

# Use entrypoint to start SQL Server
CMD chmod +x /usr/src/app/restore-backup.sh
CMD /bin/bash -c "/opt/mssql/bin/sqlservr & sleep 30s && /usr/src/app/restore-backup.sh && tail -f /dev/null"

FROM fedora
MAINTAINER Bob Brady <bob@digibrady.com>

# add our user and group first to make sure their IDs get assigned consistently
RUN groupadd postgres && useradd -s /bin/bash -g postgres -m postgres

# Install mongodb client and server
RUN dnf -y update && dnf -y install postgresql postgresql-server && dnf clean all

# Create the mongodb data dir
RUN mkdir -p /var/lib/pgsql/data

# Copy initialization script
COPY ./entrypoint.sh /var/lib/pgsql/entrypoint.sh
RUN chmod +x /var/lib/pgsql/entrypoint.sh && chown -R postgres:postgres /var/lib/pgsql

VOLUME /var/lib/pgsql/data

# Open the postgresql port to the host machine
EXPOSE 5432

# Run container as non-root user
USER postgres

ENTRYPOINT ["/var/lib/pgsql/entrypoint.sh"]

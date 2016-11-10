FROM fedora
MAINTAINER Bob Brady <bob@digibrady.com>

# add our user and group first to make sure their IDs get assigned consistently
RUN groupadd mongodb && useradd -s /bin/bash -g mongodb -m mongodb

# Install mongodb client and server
RUN dnf -y update && dnf -y install mongodb mongodb-server && dnf clean all

# Create the mongodb data dir
RUN mkdir -p /data/db && chown -R mongodb:mongodb /data

VOLUME /data/db

# Open the mongodb port to the host machine
EXPOSE 27017

# Run container as non-root user
USER mongodb

ENTRYPOINT ["/usr/bin/mongod"]

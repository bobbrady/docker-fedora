FROM fedora
MAINTAINER Bob Brady "bob@digibrady.com"

# Install nodejs and npm
RUN dnf -y update && dnf -y install npm && dnf clean all

# Install gosu - https://github.com/tianon/gosu
RUN curl -L https://github.com/tianon/gosu/releases/download/1.6/gosu-amd64 -o /usr/local/sbin/gosu; \
   chmod 0755 /usr/local/sbin/gosu

# Show nodejs and npm versions installed
RUN node -v && npm -v

# Set port for nodejs to listen on and expose it
ENV PORT 3000
EXPOSE 3000

# Move all files in the host's current dir to the working dir
WORKDIR /opt/node
COPY . /opt/node/

# Get all node proejct dependencies
RUN npm install

# Create a "node" user, chown the working dir, run as "node"
ENTRYPOINT ["/opt/node/entrypoint.sh"]

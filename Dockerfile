FROM fedora

# Install nodejs and npm
RUN dnf -y update && dnf -y install npm && dnf clean all

# Install gosu - https://github.com/tianon/gosu
RUN curl -L https://github.com/tianon/gosu/releases/download/1.6/gosu-amd64 -o /usr/local/sbin/gosu; \
   chmod 0755 /usr/local/sbin/gosu

# Show nodejs and npm versions installed
RUN node -v
RUN npm -v

# Set port for nodejs to listen on and expose it
ENV PORT 3000
EXPOSE 3000

WORKDIR /opt/node

COPY package.json entrypoint.sh /opt/node/
RUN npm install

ENTRYPOINT ["/opt/node/entrypoint.sh"]

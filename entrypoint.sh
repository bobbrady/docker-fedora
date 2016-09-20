#!/bin/bash
####################################################################################
# entrypoint.sh
#
# Shell script that creates a container "node" user having the same UID as the
# user running the container, if possible.
#
# If no environment variable for the host UID is passed into Docker, then the
# node user will be created with UID 9001.
#
# The benefit of using the UID of the host user is that mounted volumes will be
# available for edit by the host user.
####################################################################################
CONTAINER_USER_ID=${HOST_USER_ID:-9001}

echo "Starting Container with user \"node\" having UID : $CONTAINER_USER_ID"
useradd --shell /bin/bash -u $CONTAINER_USER_ID -o -c "" -m node
chown -R node:node $HOME

if [[ $# -eq 0 ]] ; then
    echo 'No arguments passed, run bash as default command'
    exec gosu node bash
fi

echo "Running as user \"node\", fired command $@"
exec gosu node "$@"

#!/bin/bash

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

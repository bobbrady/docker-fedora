# Docker Files for Fedora Microservices
This repo contains Docker files for running microservices on top of Fedora.  It contains the following:

* A Node.js container in the fedora-node dir
* A Mongo database container in the fedora-mongodb dir
* A PostgreSQL database container in teh fedora-postgresql dir
* A Docker Compose file in the top level dir that can be used to run an integrated Node.js plus MongoDB microservice environment.  It will run two separate Node.js and MongoDB containers in background.

An attempt was made to follow best practices:

* Containers are always run by a non-root user who controls the microservice, like 'node', 'mongo', or 'postgres'.
* The non-root user for Node.js will aut matically have the UID of the host user running the container. This will allow the host user to be able to edit any files copied over or created by the container user.

## Usage
* Checkout the files from the dir corresponding to the type of service app you want to run, e.g., Fedora Node for Node.js apps.
* Build the image with the given Dockerfile:
```bash
cd /path/to/Dockerfile
docker build -t <your_name>/<image-name>  .
```
* Run a container based on the built image.  Pass in the _-dt_ switch to run it in background with a pseudo-TTY terminal open. The _-t_ switch will prevent the container from shutting down without having to apply a hack command like _tail -f /dev/null_ to keep it running.  You can point to a shared volume if you want to edit files live while the container is running. Note the use of the built-in linux shell command _id_ for automatically finding the UID of the current host user.
```bash
docker run -p 3000:3000 -e HOST_USER_ID=$(id -u $USER) -v $PWD/src:/opt/node/src -dt <your_name>/fedora-node
```
* View the running container's process status
```bash
docker ps -alias
CONTAINER ID        IMAGE                      COMMAND                  CREATED             STATUS              PORTS                    NAMES
d0ba3c1f29c2        bbrady/fedora-node   "/opt/node/entrypoint"   10 seconds ago      Up 8 seconds        0.0.0.0:3000->3000/tcp   small_jones
```

* Connect to the container that is running in background via a bash shell. You can sudo as the container microservice user using the _gosu_ command.  Now you are ready to execute any of your commands!
```javascript
docker exec -it small_jones bash
[root@d0ba3c1f29c2 node]# gosu node bash
[node@d0ba3c1f29c2 node]$ ls
entrypoint.sh  package.json  src
[node@d0ba3c1f29c2 node]$
```
* When you are done running a container, you can shut it down and delete its volume:
```bash
docker rm -fv <CONTAINER_ID>
```
or to clean-up all Containers by forcing quit and removing volumes (-fv switch)
```bash
docker rm -fv $(docker ps -aq)
```

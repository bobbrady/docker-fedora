# Docker Files for Fedora Microservices
This repo contains Docker files for running microservices on top of Fedora.  An attempt was made to follow best practices:

* Containers are run by a non-root user.
* The non-root user will automatically have the UID of the host user running the container. This will allow the host user to be able to edit any files copied over or created by the container user.

## Usage
* Checkout the files from the dir corresponding to the type of service app you want to run, e.g., Fedora Node for Node.js apps.
* Build the image with the given Dockerfile:
```bash
cd /path/to/Dockerfile
docker build -t <your_name>/<image-name>  .
```
* Run a container based on the image.  You can point to a shared volume if you want to edit files live while the container is running. Note the use of the built-in linux shell command _id_ for automatically finding the UID of the current host user.
```bash
docker run -p 3000:3000 -e HOST_USER_ID=$(id -u $USER) \
  -v $PWD/src:/opt/node/src -it --rm <your_name>/<image-name>
```
* Drop into a shell for interactive user.
```bash
[node@7161d10b4afb node]$ pwd
/opt/node
[node@7161d10b4afb node]$ ls -lah
total 20K
drwxr-xr-x. 5 root root  129 Sep 20 17:54 .
drwxr-xr-x. 3 root root   18 Sep 20 17:54 ..
-rw-rw-r--. 1 root root   44 Sep 20 16:09 .dockerignore
drwxrwxr-x. 8 root root  183 Sep 20 17:20 .git
-rw-rw-r--. 1 root root   20 Sep 20 16:35 .gitignore
-rwxrwxr-x. 1 root root  958 Sep 20 17:49 entrypoint.sh
drwxr-xr-x. 3 root root   21 Sep 20 17:54 node_modules
-rw-rw-r--. 1 root root  273 Sep 20 01:14 package.json
drwxrwxr-x. 2 node node 4.0K Sep 20 16:19 src
```

* Start the example "Hello World!" node server:

```bash
[node@806d0ee8f702 node]$ npm start

> docker_web_app@1.0.0 start /opt/node
> node src/server.js

Running on http://localhost:3000

```
* Open another terminal and verify you can access the server:

```bash
$ curl -i localhost:3000
HTTP/1.1 200 OK
X-Powered-By: Express
Content-Type: text/html; charset=utf-8
Content-Length: 12
ETag: W/"c-7Qdih1MuhjZehB6Sv8UNjA"
Date: Tue, 20 Sep 2016 18:36:33 GMT
Connection: keep-alive

Hello World!
```

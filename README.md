# docker-express

This is a bare minimum Expressjs server app that is wrapped in a Docker image.

## Installation
Install Docker
[deply](#deploy)

Node JS is not required on your development machine, that is part of this image.

## Create the image

First create your site.

Here we will use index.js to server 'hello world' text message from our express server.
```
var http = require('http');

var server = http.createServer(function (request, response){
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("Hello World from expressjs in a Docker container.");
});

server.listen(8000);

console.log("Server running at http://127.0.0.1:8000/");
```

### Create the Dockerfile
The contents of the Dockerfile build script will reference

```
# Use the base image created and maintained by mhart
# It has a bare minimum installation the server and the libraries needed for an expressjs server.
FROM mhart/alpine-node
COPY index.js .
EXPOSE 8000
CMD node index.js
```

Create and run a container from the image. This will build a container with the tag "express-helloworld" and the dot indicates the Dockerfile location.
```
docker build -t express-helloworld .
```

## View the image on your machine
```
docker images
```

## Run and test your image in a container
The -ti for "terminal interactive" allows you to use ^C to kill the process.
The -p 8000:8000 options indicate the exposedPort:internalPort accessiblility.
The express-helloworld option indicates the image name to create a container.
```
docker run -ti -p 8000:8000 express-helloworld
```
Switch to your browser and get: [http://127.0.0.1:8000/](http://127.0.0.1:8000)


## Clean up
Kill the running process
```
docker kill express-helloworld
```

List container instances to be removed
```
docker ps -a
```

Remove container instances
docker rm <container id>
```
docker rm ea0ea
```

Remove images
```
docker rmi express-helloworld
docker rmi mhart/alpine-node
```

## Bonus
Add to your github repo
```
git init
git add .
## create your github repo
git remote add origin https://github.com/chrispauley/docker-express.git
git push origin master
```

### Deploy to a Docker Host <a name="Deploy"></a>
Login to your server host. At a terminal window
```
git clone https://github.com/chrispauley/docker-express.git
cd docker-express
docker build -t express-helloworld .
docker run -ti -p 8000:8000 express-helloworld
```
Make sure your server host port 8000 is accessible and test it:
 [http://192.168.0.84:8000/](http://192.168.0.84:8000/)
Update a cname record on your domain and your up.

## Clean Up
Remember to clean up your containers and images!


### Deploy to Docker Hub
First tag your image with your hub.docker.com user account name:
```
docker tag a234b052333a chrispauley/express-helloworld
docker images
```

Next, login and push to Docker hub
```
docker push chrispauley/express-helloworld
```

Now you can deploy using a docker pull command on a docker host server.
Switch to the docker host machine.
```
docker run -ti -p 8000:8000 chrispauley/express-helloworld
```
Test it from your browser and enjoy. 

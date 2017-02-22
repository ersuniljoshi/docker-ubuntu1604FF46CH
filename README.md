# Robot Framework with Docker

## Robot Framework Automation on Web

### Image File contains following Softwares:

* Ubuntu 16.04
* Pip
* Python 2.7
* Firefox 46.0
* Google-Chrome latest
* xvfb
* selenium 2.53.6
* chrome-driver 2.27

### Base Image:

* Ubuntu 16.04

### Steps to build from Github:
```
git clone https://github.com/ersuniljoshi/docker-ubuntu1604FF46CH.git
```
```
docker build -t ubuntuffch .
```
```
docker images
```

### Run Image of Docker on Chrome Browser:

```
docker run --rm -e BROWSER=Chrome -v [local-dir-path]:/home/test -ti ubuntuffch[image-name]
```

### Run Image of Docker on Firefox Browser:
```
docker run --rm -e BROWSER=firefox -v [local-dir-path]:/home/test -ti ubuntuffch[image-name]
```

### To Run Docker Image using Volume Mapping:
```
docker run --rm -e BROWSER=firefox -v [local-dir-path]:/home/test -ti ubuntuffch[image-name]
```

* Use run.sh file to run your scripts inside docker containers.
* /home/test is the path inside the container which has Robot Test Scripts which is running.
* Path after -v is the path of the test script on our local machine.
* ubuntuffch is the name of the Docker Image.


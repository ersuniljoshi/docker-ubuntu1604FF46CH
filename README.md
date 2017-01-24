# Robot Framework with Docker

## Robot Framework Automation on Web

### Image File contains following Softwares:

* Ubuntu 16.04
* Pip
* Python 2.7
* Firefox 46.0
* Google-Chrome 55.0
* xvfb

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
docker run --rm -e ROBOT_TESTS=/sample_tests -e BROWSER=Chrome -v /Users/sunil/gitrepos/roboDemo/:/sample_tests -ti ubuntuffch
```

### Run Image of Docker on Chrome Browser:
```
docker run --rm -e ROBOT_TESTS=/sample_tests -e BROWSER=Firefox -v /Users/sunil/gitrepos/roboDemo/:/sample_tests -ti ubuntuffch
```

### To Run Docker Image using Volume Mapping:
```
docker run --rm -e ROBOT_TESTS=/sample_tests -e BROWSER=Firefox -v /Users/sunil/gitrepos/roboDemo/:/sample_tests -ti ubuntuffch
```

* Use run.sh file to run your scripts inside docker containers.
* sample_tests contains the Robot Test Scripts which is to be run.
* Path after -v is the path of the test script on our local machine.
* ubuntuffch is the name of the Docker Image.

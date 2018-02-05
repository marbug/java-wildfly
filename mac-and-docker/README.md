# Wildfly (Java) / Mac + Docker #

## Prepare downloads ##

Download the following files and put them into the **./downloads** folder:

* **jdk-8u161-linux-x64.tar.gz** from [Java 8 JDK download page](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
* **wildfly-8.2.1.Final.zip** from [Wildfly download page](http://wildfly.org/downloads/)

## Prepare Dockerfile ##

### wildfly in ubuntu16 container ###

Run the following in terminal/console:

    cp Dockerfile.ubuntu16 Dockerfile

## Build iamge ##

Run the following in terminal/console:

    docker image build -t java-wildfly .

and see

    Successfully tagged java-wildfly:latest

## Run image ##

Run the following in terminal/console:

    docker container run --rm -it -p 8080:8080 java-wildfly

## Check ##

Open [http://localhost:8080/](http://localhost:8080/) in browser.

## Stop ##

Press **Ctrl** + **C** on keyboard.

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |

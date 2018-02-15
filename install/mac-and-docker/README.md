# Wildfly (Java) / Mac + Docker #

## Prepare downloads ##

Download the following files and put them into the **./downloads** folder:

* **jdk-8u161-linux-x64.tar.gz** from [Java 8 JDK download page](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)
* **wildfly-8.2.1.Final.zip** from [Wildfly download page](http://wildfly.org/downloads/)

## Prepare Dockerfile ##

## Build image ##

Run the following in terminal/console:

    ./scripts/build-image.sh centos7

or

    ./scripts/build-image.sh ubuntu16

and see

    Successfully tagged java-wildfly:latest

## Run image ##

Run the following in terminal/console:

    ./scripts/run-image.sh

## Check ##

* Open [http://localhost:8080/](http://localhost:8080/) in browser.
* Open admin console [http://localhost:9990/](http://localhost:9990/) in browser.

    * **Username:** wildfly-admin
    * **Password:** M5*k4rEV+WvzF70x

## Stop ##

Press **Ctrl** + **C** on keyboard.

| Navigation               |
| ------------------------ |
| [Level up](../../README.md) |

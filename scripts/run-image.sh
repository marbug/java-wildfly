#!/bin/sh

docker container run --rm -it -p 8080:8080 -p 9990:9990 java-wildfly

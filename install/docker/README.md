# Wildfly (Java) / Docker #

## To boot in standalone mode ##

Run

    docker run -p 8080:8080 -it jboss/wildfly

and open [http://localhost:8080/](http://localhost:8080/)

### 8.2.1.Final ###

Run

    docker run -p 8080:8080 -it jboss/wildfly:8.2.1.Final

Same with name **wildfly** 

    docker run --name wildfly -p 8080:8080 -it jboss/wildfly:8.2.1.Final

## To boot in standalone mode with admin console available remotely ##

Run

    docker run -p 8080:8080 -p 9990:9990 -it jboss/wildfly /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0

Same with name **wildfly** 

    docker run --name wildfly -p 8080:8080 -p 9990:9990 -it jboss/wildfly /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0

## TODO ##

TODO

## SSH to docker container ##

    docker exec -it wildfly bash

## Useful links ##

* [Official JBOSS Wildfly Docker page](https://hub.docker.com/r/jboss/wildfly/)

| Navigation               |
| ------------------------ |
| [Level up](../../README.md) |

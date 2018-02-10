# Wildfly (Java) / Documentation / FAQ #

## Bind to IP/All ##

### From ###

[http://blog.arungupta.me/bind-wildfly-different-ip-address-multihomed/](http://blog.arungupta.me/bind-wildfly-different-ip-address-multihomed/)

### Common ##

On a multihomed machine, you may like to start WildFly and bind “public” interface to a specific IP address. This can be easily done as:

    ./bin/standalone.sh -b=192.168.1.1

Now the applications can be accessed at http://192.168.1.1:8080.

For compatibility, -b 192.168.1.1 is also supported but -b=192.168.1.1 is recommended.

Or, if you want to bind to all available IP addresses, then you can do:

    ./bin/standalone.sh -b=0.0.0.0

### Management ##

Similarly, by default, WildFly can be managed using Admin Console at http://127.0.0.1:9990. 9990 is the management port.

WildFly “management” interface can be bound to a specific IP address as:

    ./bin/standalone.sh -bmanagement=192.168.1.1
 
Now Admin Console can be accessed at http://192.168.1.1:9990.

Or, bind “management” interface to all available IP addresses as:

    ./bin/standalone.sh -bmanagement=0.0.0.0

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |


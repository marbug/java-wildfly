# Wildfly (Java) #

## About ##

This repo has been created to help running wildfly in:

* [Mac + Docker](mac-and-docker/README.md)
* [Mac + Vagrant + VirtualBox](mac-and-vagrant-and-virtualbox/README.md)
* [Windows + Vagrant + VirtualBox](windows-and-vagrant-and-virtualbox/README.md)
* TODO

environments.

## Prepare software ##

Please ensure that you have installed the latest versions of Docker, Vagrant and/or VirtualBox.

See **Useful links** section below for more details.

## Windows + Vagrant vs Windows + Docker ##

### VBoxManage.exe: error: VT-x is not available ###

[From stackoverflow](https://stackoverflow.com/questions/37955942/vagrant-up-vboxmanage-exe-error-vt-x-is-not-available-verr-vmx-no-vmx-code):

I just solved this problem by disabling(uncheck) Hyper-V. Seems Hyper-V was enabled when I installed Docker

    Control Panel -> Program And Features -> Turn Windows Features on or off.

You may need to reboot afterwords.

**Warning:** Vagrant with VirtualBox cannot work with Docker at the same time.

TODO

## Useful links ##

* [Docker community edition download](https://www.docker.com/community-edition)
* [Vagrant download page](https://www.vagrantup.com/downloads.html)
* [VirtualBox download page](https://www.virtualbox.org/wiki/Downloads)
* [Wildfly official site](http://wildfly.org/)
* [Wildfly download page](http://wildfly.org/downloads/)
* [Java 8 JDK download page](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

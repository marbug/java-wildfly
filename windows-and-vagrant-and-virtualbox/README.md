# Wildfly (Java) / Windows + Vagrant + VirtualBox #

## TODO ##

TODO

## Issues ##

### VBoxManage.exe: error: VT-x is not available ###

[From stackoverflow](https://stackoverflow.com/questions/37955942/vagrant-up-vboxmanage-exe-error-vt-x-is-not-available-verr-vmx-no-vmx-code):

> I just solved this problem by disabling(uncheck) Hyper-V. Seems Hyper-V was enabled when I installed Docker

    Control Panel -> Program And Features -> Turn Windows Features on or off.

> You may need to reboot afterwords.

> **Warning:** Vagrant with VirtualBox cannot work with Docker at the same time.

| Navigation               |
| ------------------------ |
| [Level up](../README.md) |

# Demonstration

Sometimes you need/want to demonstrate e.g. Docker to your students or another person. 
So you need a demonstration enviroment. But you don't want to do everything manually. 
This repository has several scripted demonstration environments. 

## [Step 0]

Setup Vagrant environment. 

More information on setting up the Vagrant environment can be found is [this](https://github.com/jatutert/Vagrant) repository. 

## [Step 1]

Creating virtual machine using my vagrantfile (Vagrant and VMware Workstation PRO must be installed!)

```shell
vagrant up U24-LTS-S-DCKR-001
exit
```

## [Step 2]

Prepare the virtual machine for demonstration using bash shell script. 

```shell
vagrant ssh U24-LTS-S-DCKR-001 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh docker" 
exit
```
This script installs Docker within the Ubuntu virtual machine and also creates an demo environment for demos with Docker. 

The runtime for the script is about 10 to 15 minutes (depends on your processor and internal memory) 

## [Step 3]

Enter the virtual machine 

```shell
vagrant ssh U24-LTS-S-DCKR-001
exit
```

## [Step 4]

Give demonstration

```shell
docker run -it alpine:latest /bin/sh  
exit
```

Cockpit is available on port 1234
Portainer is available on port 9443

If you get a time out error on portainer, the restart the container
```shell
docker stop portainer
docker start portainer
ip addr
exit
```

## [Step 5]

Shutdown the virtual machine 

```shell
vagrant halt U24-LTS-S-DCKR-001
exit
```

## [Step 6]

Booting the virtual machine 

```shell
vagrant up U24-LTS-S-DCKR-001
exit
```

## [Step 7]

Removing the virtual machine 

```shell
vagrant halt U24-LTS-S-DCKR-001
vagrant destroy U24-LTS-S-DCKR-001 --force 
exit
```

## License / Copyright / Trademarks 
> - Vagrant by Hashicorp Inc. (hashicorp.com) 
> - Virtualbox by Oracle Corporation (oracle.com) 
> - VMware by VMware Company (vmware.com) / Broadcom (broadcom.com) 
> - Windows by Microsoft Corporation (microsoft.com)

Everything I describe is intended for personal or educational use. In my case, that is primarily educational use. 

All references to and quotations from external sources are licensed and/or copyright the respective owners. 
I make no claim to ownership of these sources. 
References to and quotations from these sources have been used on the basis of assumption of reasonableness and fair use. 
To my knowledge, no copyright or other rights have been infringed. 
If it is believed that references to and/or quotations from certain external sources violate any rules, rights or interests, please contact.

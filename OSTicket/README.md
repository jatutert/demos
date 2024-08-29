# Demonstration

Sometimes you need/want to demonstrate e.g. Docker to your students or another person. 
So you need a demonstration enviroment. But you don't want to do everything manually. 
This repository has several scripted demonsration environments. 
Some are still in alpha version and other ones are more advanced !

## OSTicket

This demo environment that consists of two virtual machines. 
The first virtual machine runs the web server. 
The other virtual machine runs the database server. 

This environment automatically creates the virtual machines mentioned above and provides these virtual machines with all the software. 
However, the configuration of OSTicket still needs to be done manually. 
It is planned to make this automatic in the future as well. 
Unfortunately, I have not reached that point yet. 

### Starting the virtual machines

Sizing for the Linux Virtual machines: 
S = 2 GB RAM.
L = 4 GB RAM.
XL = 8 GB RAM. 

Below an example how to start the XL version of the virtual machines (e.g. U24-LTS-S-WSRV-XL-001)
Change XL to L or S for smaller size (e.g. U24-LTS-S-WSRV-S-001)

```shell
vagrant up U24-LTS-S-DBMS-XL-001 
vagrant up U24-LTS-S-WSRV-XL-001
```

Starting the Windows virtual machines 

```shell
vagrant up W11-ENT-D-OSTKT-CLNT 
vagrant up W22-STD-S-OSTKT-RTR 
```

### Configuring the Linux virtual machines 

```shell
vagrant ssh U24-LTS-S-DBMS-XL-001 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh introinfra"
vagrant ssh U24-LTS-S-WSRV-XL-001 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh introinfra" 
```

### Give demonstration to your public (e.g. students) 

Sizing for the Linux Virtual machines: 
S = 2 GB RAM.
L = 4 GB RAM.
XL = 8 GB RAM. 

Below an example how to SSH to the XL version of the virtual machines (e.g. U24-LTS-S-WSRV-XL-001)
Change XL to L or S for smaller size (e.g. U24-LTS-S-WSRV-S-001)
The size must be the same size as defined at the starting of the virtual machine. 

Database Server
```shell
vagrant ssh U24-LTS-S-DBMS-XL-001
```

Webserver
```shell
vagrant ssh U24-LTS-S-WSRV-XL-001
```

Windows 11 
```shell
vagrant ssh W11-ENT-D-OSTKT-CLNT
```

Windows Server 2022 Standard 
```shell
vagrant ssh W22-STD-S-OSTKT-RTR
```

### Shutdown 

For shutting down the virtual machines (e.g. at the end of the lesson) execute the steps below: 

```shell
vagrant halt U24-LTS-S-DBMS-XL-001
vagrant halt U24-LTS-S-WSRV-XL-001
vagrant halt W11-ENT-D-OSTKT-CLNT
vagrant halt W22-STD-S-OSTKT-RTR
```

### Restart

For booting the virtual machines (e.g. new lesson or at home) execute the steps below: 

```shell
vagrant up U24-LTS-S-DBMS-XL-001
vagrant up U24-LTS-S-WSRV-XL-001
vagrant up W11-ENT-D-OSTKT-CLNT
vagrant up W22-STD-S-OSTKT-RTR
```

### Remove

For complete removal of the virtual machines execute the steps below: 

```shell
vagrant halt U24-LTS-S-DBMS-XL-001
vagrant halt U24-LTS-S-WSRV-XL-001
vagrant halt W11-ENT-D-OSTKT-CLNT
vagrant halt W22-STD-S-OSTKT-RTR
vagrant destroy U24-LTS-S-DBMS-XL-001 --force
vagrant destroy U24-LTS-S-WSRV-XL-001 --force
vagrant destroy W11-ENT-D-OSTKT-CLNT --force
vagrant destroy W22-STD-S-OSTKT-RTR --force 
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



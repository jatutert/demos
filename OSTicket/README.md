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

```shell
vagrant up U24-LTS-S-DBMS-XL-001 U24-LTS-S-WSRV-XL-001 --parallel --timestamp
vagrant up W11-ENT-D-OSTKT-CLNT W22-STD-S-OSTKT-RTR --parallel --timestamp
```

### Configuring the Linux virtual machines 

```shell
vagrant ssh U24-LTS-S-DBMS-XL-001 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh introinfra"
vagrant ssh U24-LTS-S-WSRV-XL-001 --command "sudo /home/vagrant/ubuntu-config-V3-latest.sh introinfra" 
```

### Give demonstration to your public (e.g. students) 

Database Server
```shell
vagrant ssh U24-LTS-S-DBMS-001
```

Webserver
```shell
vagrant ssh U24-LTS-S-WSRV-001
```

Windows 11 
```shell
vagrant ssh W11-ENT-D-OSTKT-CLNT
```

Windows Server 2022 Standard 
```shell
vagrant ssh W22-STD-S-OSTKT-RTR
```



# Demonstration

Sometimes you need/want to demonstrate e.g. Docker to your students or another person. 
So you need a demonstration enviroment. But you don't want to do everything manually. 
This repository has several scripted demonstration environments. 

## Vagrant

Minikube can be executed in several ways. 
One of the many way is to run Minikube inside a virtual machine (running Linux) on top of Docker. 
This demo uses a virtual machine within VMware Workstation or Fusion Pro running Ubuntu linux. 
Control of this environment is done with Vagrant from Hashicorp. 

To use this demo environment, Vagrant environment must first be set up. 
See the separate repository called Vagrant for more information on this. 

## Windows

Minikube can also be run within Windows (i.e. not within a virtual machine). 
In the background, Minikube does use a virtual machine. 
This virtual machine can run on Oracle Virtualbox but also on VMware Workstation Pro. 
The Windows folder mainly contains command files for controlling Minikube to give demos. 

```shell
winget install --id Kubernetes.minikube
winget install -e --id Kubernetes.kubectl
exit
```

```shell
Setx MINIKUBE_IN_STYLE "false"
Setx MINIKUBE_HOME "The directory you want the virtual machine be created"
exit
```

```shell
minikube config set memory 8192
minikube config set cpus 4 
minikube config set driver vmware 
minikube config set WantBetaUpdateNotification true
minikube config set WantVirtualBoxDriverWarning false
exit
```

```shell
minikube start --no-kubernetes
minikube ssh
```

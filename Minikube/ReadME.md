# Minikube 
In order to give a good demonstration of Kubernetes, it is useful to have materials that you can use for a demonstration. 
This folder contains these materials for demonstration purposes. 

## Native Driver Docker
Minikube using Docker as driver. On top of Docker the worker nodes of the Kubernetes cluster are created. 
Docker is installed on top of the Operating System, which also runs Minikube. 

## Native-Driver-Docker-Desktop-WSL2
Minikube using Docker als driver. On top of Docker the worker nodes of the Kubernetes cluster are created. 
Compatible with Docker Desktop. Docker is running within Linux virtual machine on top of Hyper-V hypervisor. 
The virtual machine is running Alpine Linux and the latest version of Docker. 

## Native-Driver-Virtualbox
Minikube creates its own virtual machine on top of the Oracle VM Virtualbox hypervisor. 

## Native-Driver-VMWare
Minikube creates its own virtual machine on top of the VMWare Workstation Pro hypervisor. 

## VM-Custom-on-WSL2
Virtual Machine running on top of the Hyper-V hypervisor. The Virtual machine is custom made (not running Alpine). 
The virtual machine contains Docker. The worker nodes run on top of Docker within the virtual machine. 

## VM-Virtualbox
Virtual machine running on top of the Oracle Virtualbox Hypervisor. 
The virtual machine contains Docker. The worker nodes run on top of Docker within the virtual machine. 

## VM-VMware
Virtual machine running on top of the VMware Workstation PRo Hypervisor.
The virtual machine contains Docker. The worker nodes run on top of Docker within the virtual machine. 

## VM-VMware-Vagrant
Same as VM-VMware, but now with Vagrant operating VMware Workstation Pro. 

## License / Copyright / Trademarks 
> - Virtualbox by Oracle Corporation (oracle.com) 
> - VMware by VMware Company (vmware.com) / Broadcom (broadcom.com) 
> - Windows by Microsoft Corporation (microsoft.com)

Everything I describe is intended for personal or educational use. In my case, that is primarily educational use. 

All references to and quotations from external sources are licensed and/or copyright the respective owners. 
I make no claim to ownership of these sources. 
References to and quotations from these sources have been used on the basis of assumption of reasonableness and fair use. 
To my knowledge, no copyright or other rights have been infringed. 
If it is believed that references to and/or quotations from certain external sources violate any rules, rights or interests, please contact.

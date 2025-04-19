# Windows Demonstration

Sometimes you need/want to demonstrate e.g. Docker to your students or another person. 
So you need a demonstration enviroment. But you don't want to do everything manually. 
This repository has several scripted demonsration environments. 
Some are still in alpha version and other ones are more advanced !

## Guest

Main focus is the guest running on top of the hypervisor.
The Hypervisor is NOT part of this. 

## Hypervisor

Main focus is the hypervisor running on the host beside the operating system. 
It manages the hypervisor in creating the guest (see above). 

## Virtual Harddisk

Main focus is the virtual harddisk used by the guest on top of the hypervisor. 
Think of VHD, VMDK and VDI files. 
VHD files run with Hyper-V and Oracle VM Virtualbox. 
VMDK files run with Oracle VM Virtualbox and VMWare Workstation or Fusion PRO
VDI files run only with Oracle VM Virtualbox. 
Also the conversion of e.g. VHD to VMDK is included in this part. 
 
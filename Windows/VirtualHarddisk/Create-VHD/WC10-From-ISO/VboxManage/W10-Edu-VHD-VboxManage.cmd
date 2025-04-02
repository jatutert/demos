::
::	Script om VM te maken met VHD
::	Doel is VHD maken en later gebruiken
::
::	30 mei 2024
::	John Tutert
::
::	Handleiding
::	https://docs.oracle.com/en/virtualization/virtualbox/7.0/user/vboxmanage.html#vboxmanage
::
::
VBoxManage createvm --name "W10-EDU-VHD-CREATE" --basefolder "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client" --default --ostype "Windows10_64" --register 
VBoxManage -q modifyvm W10-EDU-VHD-CREATE --description="Windows 10 Education VHD Create VM"
VBoxManage -q modifyvm W10-EDU-VHD-CREATE --cpus=2
VBoxManage -q modifyvm W10-EDU-VHD-CREATE --memory=4096
VBoxManage -q modifyvm W10-EDU-VHD-CREATE --vram 256
VBoxManage -q modifyvm W10-EDU-VHD-CREATE --accelerate-3d=off
VBoxManage -q modifyvm W10-EDU-VHD-CREATE --accelerate-2d-video=off
:: VBoxManage -q modifyvm W10-EDU-VHD-CREATE --vrde=on
:: VBoxManage -q modifyvm W10-EDU-VHD-CREATE --vrde-port=5908
VBoxManage -q modifyvm W10-EDU-VHD-CREATE --boot1=dvd
VBoxManage -q modifyvm W10-EDU-VHD-CREATE --boot2=disk
VBoxManage -q modifyvm W10-EDU-VHD-CREATE --boot3=none
VBoxManage -q modifyvm W10-EDU-VHD-CREATE --boot4=none
VBoxManage -q modifyvm W10-EDU-VHD-CREATE --audio-enabled=on

:: Maak VHD met maximale omvang van 60 GB 
VBoxManage createmedium disk --filename=D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\W10-EDU-VHD-CREATE\W10-EDU-VHD-CREATE.vhd --size=61440 --format=vhd --variant=standard 


VBoxManage storageattach "W10-EDU-VHD-CREATE" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\W10-EDU-VHD-CREATE\W10-EDU-VHD-CREATE.vhd"
::
:: 	DVD Windows 10 (met autounattend.xml) 
::
VBoxManage storageattach "W10-EDU-VHD-CREATE" --storagectl "SATA" --port 1 --device 0 --type dvddrive --medium "D:\Installatie-Catalogus\ISO\Besturingssystemen\Windows\10-10-11\10.10-Windows-10\22H2-19045\Regulier\Consumer-Editions-Home-Eudcation-PRO\EN-US\Win10-Consumer_may_2023_autounattend_jtu03.iso"
::

VBoxManage unattend 
Zie https://www.virtualbox.org/manual/ch08.html#vboxmanage-unattended


::
::
VBoxManage -q --nologo startvm W10-EDU-VHD-CREATE --type=gui
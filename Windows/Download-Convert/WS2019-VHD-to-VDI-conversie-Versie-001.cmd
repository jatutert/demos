:: 
:: Conversie VHD naar Oracle VM Virtualbox VDI
:: Versie 001
:: 5 april 2024
:: John Tutert  
:: 
:: VBOXMANAGE
:: Handleiding https://www.virtualbox.org/manual/ch08.html
:: 
:: == CLONEMEDIUM == 
:: 
:: VBoxManage clonemedium <uuid | source-medium> <uuid | target-medium> [disk | dvd | floppy] [--existing] [--format= VDI | VMDK | VHD | RAW | other ] [--variant=Standard,Fixed,Split2G,Stream,ESX]
::
:: --format Specifies the file format of the target medium if it differs from the format of the source medium. Valid values are VDI, VMDK, VHD, RAW, and other.
::
:: --variant=Standard,Fixed,Split2G,Stream,ESX
:: Specifies the file format variant for the target medium, which is a comma-separated list of variants. Following are the valid values:
:: Standard is the default disk image type, which has a dynamically allocated file size.
:: Fixed uses a disk image that has a fixed file size.
:: Split2G indicates that the disk image is split into 2GB segments. This value is for VMDK only.
:: Stream optimizes the disk image for downloading. This value is for VMDK only.
:: ESX is used for some VMWare products. This value is for VMDK only.
:: 
VBoxManage.exe clonemedium disk --format=VDI "D:\Virtual-Machines\Templates\Windows-Server\2019\17763.737.amd64fre.rs5_release_svc_refresh.190906-2324_server_serverdatacentereval_en-us_1.vhd" D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\WS19DS.vdi
::
::	Windows 10 Education Virtual Machine Creator
::
::	Werkt alleen op laptop CND0475SYS 
::
::	[0]	Omgeving
::	[1] ISO Download
::	[2] Convert ISO to VHD
::	[3] Create Virtual Machine
::
::	Script
::	Version 002
::	07 juni 2024
::
::	John Tutert
::
::	[0] OMGEVING
::
::	Installeren Convert-WimImage in Powershell
:: 	powershell Install-Module -Name Hyper-ConvertImage -Repository PSGallery
::
::	[1] ISO Download
::
::	Downloaden Windows 10 ISO Bestand 
::
::	Download site https://massgrave.dev/windows_10_links
::
::	powershell Invoke-WebRequest -URI https://drive.massgrave.dev/en-us_windows_10_consumer_editions_version_22h2_updated_may_2024_x64_dvd_49ddadb6.iso -OutFile %userprofile%\Downloads\en-us_windows_10_consumer_editions_version_22h2_updated_may_2024_x64_dvd_49ddadb6.iso
::
::
::	[2] Convert ISO to VHD
::
::
::	Download Powershell script voor conversie van eigen GitHub
::	powershell Invoke-WebRequest -URI    -OutFile %userprofile%\Downloads\
::









:: Create Virtual Machine
@VBoxManage createvm --name "WC11E-T-001" --basefolder "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client" --default --ostype "Windows11_64" --register 
::
:: Aanpassingen doen aan VM
@echo Instellingen Virtuele Machine aanpassen ... 
@VBoxManage -q modifyvm WC11E-T-001 --description="Windows 11 Enterprise DEV Environment (Trial)"
:: MOET OP EFI STAAN @VBoxManage -q modifyvm WC11E-T-001 --firmware=bios
@VBoxManage -q modifyvm WC11E-T-001 --cpus=4
@VBoxManage -q modifyvm WC11E-T-001 --memory=8192
@VBoxManage -q modifyvm WC11E-T-001 --vram 256
@VBoxManage -q modifyvm WC11E-T-001 --accelerate-3d=on
@VBoxManage -q modifyvm WC11E-T-001 --accelerate-2d-video=on
@VBoxManage -q modifyvm WC11E-T-001 --vrde=on
@VBoxManage -q modifyvm WC11E-T-001 --vrde-port=5908
@VBoxManage -q modifyvm WC11E-T-001 --boot1=disk
@VBoxManage -q modifyvm WC11E-T-001 --boot2=dvd
@VBoxManage -q modifyvm WC11E-T-001 --boot3=none
@VBoxManage -q modifyvm WC11E-T-001 --boot4=none
@VBoxManage -q modifyvm WC11E-T-001 --audio-enabled=off
@VBoxManage -q modifyvm WC11E-T-001 --clipboard-mode=bidirectional --drag-and-drop=bidirectional
@VBoxManage -q modifyvm WC11E-T-001 --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
:: VBoxManage -q sharedfolder add WC11E-T-001 --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/ubuntu/downloads"
:: 
::
:: VM Aanpassen zodat VDI wordt gebruikt 
@echo Koppelen VMDK aan Virtuele Machine ... 
@VBoxManage storageattach "WC11E-T-001" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\WC11E-T-001\WC11E-T-001.vmdk"
::
:: STarten VM
:: VBoxManage -q --nologo startvm WC11E-T-001 --type=gui
::
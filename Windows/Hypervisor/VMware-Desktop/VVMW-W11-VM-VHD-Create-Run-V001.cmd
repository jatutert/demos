::
::	Windows 11 Education Virtual Machine Creator
::
::	Werkt alleen op laptop CND0475SYS 

@echo off
@cls
@echo. 
@echo Windows 11 23H2 Education Virtual Machine Creator
@echo.
@echo Oracle VM Virtualbox is used as Hypervisor
@echo.
@echo ALPHA Version (only for testing purposes) 
@echo. 
@echo Created june 20 2024 
@echo.
@echo By John Tutert 
@echo.
@echo Only for personal and/or educational use ! 
@echo. 
::
::	[0]	Omgeving
::	[1] ISO Download
::	[2] Convert ISO to VHD
::	[3] Create Virtual Machine
::
::	Script
::	Version 002 (7 juni 2024) 
::	Aangepast 10 juni 2024
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
::	Resultaat EN-US-W10-Edu-22H2.VHD
::
@echo Maken VHD-bestand gestart mbv Powershell Hyper-ConvertImage versie 10.2
@echo AutoUnattend Scheegans versie 001 wordt gebruikt ...  
::
::	Schneegans autoattend versie 001 wordt gebruikt
::
@powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Windows\VirtualHarddisk\VHD\W11-ISO-VHD-VM\Eigen-VHD-Powershell\VHDPath-Virtual-Machines\"W11-EDU-Create-VHD-V002.ps1
::
::
:: 	[3] Create Virtual Machine
::
::		E	=	Enterprise 
::		O	= 	Education 
::		P	=	PRO
::
@echo Maken en configureren virtuele machine gestart ... 
::
:: getest 01-04-2025 werkt !
:: maakt vmx en vmdk  
vmcli VM Create -n W11-EDU-C-WS01 -d D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client -g windows11-64
::

Zie
https://samson-ok.medium.com/automating-vm-creation-in-vmware-workstation-97c32671a7a1

:: Virtualbox
:: @VBoxManage -q createvm --name "W11-EDU-C-WS01" --basefolder "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client" --default --ostype "Windows10_64" --register
::



:: Aanpassingen doen aan VM
::
::	Met ConfigParams SetEntry kun je settings in de VMX aanpassen
::	Zie VMX voor welke settings je aan kan passen 
::
vmcli ConfigParams SetEntry displayName W11-EDU-C-WS01 D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\W11-EDU-C-WS01.vmx
vmcli ConfigParams SetEntry memsize 8192 D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\W11-EDU-C-WS01.vmx

vmcli.exe Ethernet SetConnectionType ethernet0 nat "D:\Virtual-Machines\VMware-Workstation-PRO\Windows\Client\W11-EDU-C-WS01.vmx"

Zie
https://samson-ok.medium.com/automating-vm-creation-in-vmware-workstation-97c32671a7a1




@VBoxManage -q modifyvm W11-EDU-C-WS01 --description="Windows 10 LAB 001"
@VBoxManage -q modifyvm W11-EDU-C-WS01 --firmware=efi64
@VBoxManage -q modifyvm W11-EDU-C-WS01 --bios-logo-fade-in=off
@VBoxManage -q modifyvm W11-EDU-C-WS01 --bios-logo-fade-out=off
@VBoxManage -q modifyvm W11-EDU-C-WS01 --cpus=2
@VBoxManage -q modifyvm W11-EDU-C-WS01 --memory=8192
@VBoxManage -q modifyvm W11-EDU-C-WS01 --guest-memory-balloon=2048
@VBoxManage -q modifyvm W11-EDU-C-WS01 --vram 256
:: @VBoxManage -q modifyvm W11-EDU-C-WS01 --accelerate-3d=on
:: @VBoxManage -q modifyvm W11-EDU-C-WS01 --accelerate-2d-video=on
:: @VBoxManage -q modifyvm W11-EDU-C-WS01 --vrde=on
:: @VBoxManage -q modifyvm W11-EDU-C-WS01 --vrde-port=5908
@VBoxManage -q modifyvm W11-EDU-C-WS01 --boot1=disk
@VBoxManage -q modifyvm W11-EDU-C-WS01 --boot2=dvd
@VBoxManage -q modifyvm W11-EDU-C-WS01 --boot3=none
@VBoxManage -q modifyvm W11-EDU-C-WS01 --boot4=none
@VBoxManage -q modifyvm W11-EDU-C-WS01 --audio-enabled=on
@VBoxManage -q modifyvm W11-EDU-C-WS01 --clipboard-mode=bidirectional --drag-and-drop=bidirectional
@VBoxManage -q modifyvm W11-EDU-C-WS01 --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
:: VBoxManage -q sharedfolder add W11-EDU-C-WS01 --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/ubuntu/downloads"
:: 
::
::
@move "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client"\W11-EDU-C-LAB-001.VHD "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\W11-EDU-C-WS01"\W11-EDU-C-LAB-001.VHD
::
:: Verbind nieuwe VHD met de nieuwe virtuel machine 
@VBoxManage -q storageattach "W11-EDU-C-WS01" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\W11-EDU-C-WS01\W11-EDU-C-LAB-001.VHD"
::
:: STarten VM

vmrun -T ws start "c:\my VMs\myVM.vmx"


@VBoxManage -q startvm W11-EDU-C-WS01 --type=gui
::
:: 	Virtualbox Guest Additions bijwerken
::
::	Gaat fout omdat gelijk na start wordt gedaan 
::	Moet eerst wachten totdat installatie is afgerond
::	Wachttijd inbouwen
::
:: @VBoxManage -q guestcontrol "W11-EDU-C-WS01" updatega 
::
::
::	That's all folks ! 
@echo Einde script ... 
::
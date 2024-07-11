::
::	Windows Server 2022 Virtual Machine Creator
::
::	Werkt alleen op laptop CND0475SYS 

@echo off
@cls
@echo. 
@echo Windows Server 2022 Virtual Machine Creator
@echo.
@echo Oracle VM Virtualbox is used as Hypervisor
@echo.
@echo ALPHA Version (only for testing purposes) 
@echo. 
@echo Created july 5 2024 
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
@powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Windows\VirtualHarddisk\VHD\W22-ISO-VHD-VM\Eigen-VHD-Powershell\VHDPath-Virtual-Machines"\W22-DTC-Create-VHD-V003.ps1
::
::
:: 	[3] Create Virtual Machine
::
::		E	=	Enterprise 
::		O	= 	Education 
::		P	=	PRO
::
@echo Maken en configureren virtuele machine gestart ... 
@VBoxManage -q createvm --name "W22-DTC-S-LAB01" --basefolder "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server" --default --ostype "Windows2022_64" --register
::
:: Aanpassingen doen aan VM
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --description="Windows Server 2022 DataCenter LAB 001"
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --firmware=efi64
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --bios-logo-fade-in=off
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --bios-logo-fade-out=off
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --cpus=2
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --memory=8192
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --guest-memory-balloon=2048
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --vram 256
:: @VBoxManage -q modifyvm W22-DTC-S-LAB01 --accelerate-3d=on
:: @VBoxManage -q modifyvm W22-DTC-S-LAB01 --accelerate-2d-video=on
:: @VBoxManage -q modifyvm W22-DTC-S-LAB01 --vrde=on
:: @VBoxManage -q modifyvm W22-DTC-S-LAB01 --vrde-port=5908
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --boot1=disk
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --boot2=dvd
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --boot3=none
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --boot4=none
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --audio-enabled=on
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --clipboard-mode=bidirectional --drag-and-drop=bidirectional
@VBoxManage -q modifyvm W22-DTC-S-LAB01 --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
:: VBoxManage -q sharedfolder add W22-DTC-S-LAB01 --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/ubuntu/downloads"
:: 
::
::
@move "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server"\W22-DTC-S-LAB-001.VHD "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W22-DTC-S-LAB01"\W22-DTC-S-LAB-001.VHD 
::
:: Verbind nieuwe VHD met de nieuwe virtuel machine 
@VBoxManage -q storageattach "W22-DTC-S-LAB01" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W22-DTC-S-LAB01"\W22-DTC-S-LAB-001.VHD"
::
:: STarten VM
@VBoxManage -q startvm W22-DTC-S-LAB01 --type=gui
::
:: 	Virtualbox Guest Additions bijwerken
::
::	Gaat fout omdat gelijk na start wordt gedaan 
::	Moet eerst wachten totdat installatie is afgerond
::	Wachttijd inbouwen
::
:: @VBoxManage -q guestcontrol "W22-DTC-S-LAB01" updatega 
::
::
::	That's all folks ! 
@echo Einde script ... 
::
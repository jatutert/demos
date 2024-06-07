:: Microsoft Windows 11 Enterprise
:: Virtual Machine 
:: Download and Create and Run
:: 
:: Oracle VM Virtualbox Edition
:: 
:: Version 1
:: Alpha
::
:: John Tutert
:: 
:: Changelog
:: 
:: 12 apr - Eerste versie van script gemaakt
:: 
::
:: :::: OPRUIMEN ::::
:: 
:: Stoppen eventueel draaiende virtuele machine
@VBoxManage -q controlvm WC11E-T-001 poweroff
:: Verwijderen virtuele machine uit Oracle VM Virtualbox
@VBoxManage -q unregistervm WC11E-T-001 --delete-all
:: Schoonmaken Oracle VM Virtualbox Medium lijst om foutmelding UUID te voorkomen 
@VBoxManage closemedium disk D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC11E-Trial.VHDX >nul 2>&1
@VBoxManage closemedium disk D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC11E-Trial.vdi >nul 2>&1
:: Onderstaande melding zorgt voor foutmelding omdat VM niet meer bestaat 
@VBoxManage closemedium disk D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\WC11E-T-001\WC11E-Trial.vdi >nul 2>&1
:: 
:: :::: Bijwerken ::::
@VBoxManage -q updatecheck perform
@VBoxManage extpack cleanup
:: 
:: :::: Downloaden VHD ::::
:: 
:: Virtual Hardware Lab Kit 
:: https://www.microsoft.com/en-us/evalcenter/download-virtual-hardware-lab-kit
:: 
:: HD Size 34 GB 
:: 23H2 Edition 
::
:: 
:: Staat als 23H2 maar is Windows Server 2022
:: https://go.microsoft.com/fwlink/?linkid=2250141&clcid=0x409&culture=en-us&country=us
::
:: Staat als 22H2 maar is Windows Server 2019
:: https://go.microsoft.com/fwlink/p/?linkid=2196266&clcid=0x409&culture=en-us&country=us
::
::
:: Foutmelding No CAs were found in 'C:\ProgramData/ssl/ca-bundle.pem'
if not exist D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC11E-VHLK-Trial.VHDX (
   @wget2 -O D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC11E-VHLK-Trial.VHDX "https://go.microsoft.com/fwlink/p/?linkid=2196266&clcid=0x409&culture=en-us&country=us"
) 
::
:: Conversie VHD naar VDI
:: Oracle VM Virtualbox doet ook automatische registratie van zowel VMDK als VDI in Medium lijst
@VBoxManage.exe clonemedium disk --format=VDI "D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC11E-VHLK-Trial.VHDX" D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC11E-VHLK-Trial.vdi
:: 
:: Create Virtual Machine
@VBoxManage createvm --name "WC11E-T-001" --basefolder "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client" --default --ostype "Windows11_64" --register 
::
:: Aanpassingen doen aan VM
@VBoxManage -q modifyvm WC11E-T-001 --description="Windows 11 Enterprise Windows Virtual Hardware Lab Kit (VHLK)"
@VBoxManage -q modifyvm WC11E-T-001 --firmware=bios
@VBoxManage -q modifyvm WC11E-T-001 --cpus=2
@VBoxManage -q modifyvm WC11E-T-001 --memory=8192
@VBoxManage -q modifyvm WC11E-T-001 --boot1=disk
@VBoxManage -q modifyvm WC11E-T-001 --boot2=dvd
@VBoxManage -q modifyvm WC11E-T-001 --boot3=none
@VBoxManage -q modifyvm WC11E-T-001 --boot4=none
@VBoxManage -q modifyvm WC11E-T-001 --audio-enabled=off
@VBoxManage -q modifyvm WC11E-T-001 --clipboard-mode=bidirectional --drag-and-drop=bidirectional
@VBoxManage -q modifyvm WC11E-T-001 --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
:: VBoxManage -q sharedfolder add WC11E-T-001 --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/ubuntu/downloads"
:: 
:: Overzetten VDI naar VM Directory
copy "D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC11E-VHLK-Trial.vdi" "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\WC11E-T-001\WC11E-T-001.vdi"
::
:: Virtual Hardisk voorzien van nieuwe UUID
@VBoxManage internalcommands sethduuid D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\WC11E-T-001\WC11E-T-001.vdi
::
:: Verwijderen VDI
@del "D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC11E-VHLK-Trial.vdi"
@VBoxManage closemedium disk D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC11E-VHLK-Trial.vdi
::
:: VM Aanpassen zodat VDI wordt gebruikt 
@VBoxManage storageattach "WC11E-T-001" --storagectl "SATA" --port 0 --device 0 --type hdd --medium D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\WC11E-T-001\WC11E-T-001.vdi
::
:: STarten VM
:: VBoxManage -q --nologo startvm WC11E-T-001 --type=gui
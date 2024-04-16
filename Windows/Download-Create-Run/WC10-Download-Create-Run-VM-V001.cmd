:: Microsoft Windows 10 Enterprise
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
@VBoxManage -q controlvm WC10E-T-001 poweroff
:: Verwijderen virtuele machine uit Oracle VM Virtualbox
@VBoxManage -q unregistervm WC10E-T-001 --delete-all
:: Schoonmaken Oracle VM Virtualbox Medium lijst om foutmelding UUID te voorkomen 
@VBoxManage closemedium disk D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC10E-Trial.VHDX >nul 2>&1
@VBoxManage closemedium disk D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC10E-Trial.vdi >nul 2>&1
:: Onderstaande melding zorgt voor foutmelding omdat VM niet meer bestaat 
@VBoxManage closemedium disk D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\WC10E-T-001\WC10E-Trial.vdi >nul 2>&1
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
:: HD Size 30 GB
:: 2004 Edition  
::
:: Foutmelding No CAs were found in 'C:\ProgramData/ssl/ca-bundle.pem'
if not exist D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC10E-Trial.VHDX (
   @wget2 -O D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC10E-Trial.VHDX "https://go.microsoft.com/fwlink/p/?linkid=2195402&clcid=0x409&culture=en-us&country=us"
) 
::
:: Conversie VHD naar VDI
:: Oracle VM Virtualbox doet ook automatische registratie van zowel VMDK als VDI in Medium lijst
@VBoxManage.exe clonemedium disk --format=VDI "D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC10E-Trial.VHDX" D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC10E-Trial.vdi
:: 
:: Create Virtual Machine
@VBoxManage createvm --name "WC10E-T-001" --basefolder "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client" --default --ostype "Windows11_64" --register 
::
:: Aanpassingen doen aan VM
@VBoxManage -q modifyvm WC10E-T-001 --description="Windows 11 Enterprise Trial"
@VBoxManage -q modifyvm WC10E-T-001 --audio-enabled=off
@VBoxManage -q modifyvm WC10E-T-001 --memory=8192
@VBoxManage -q modifyvm WC10E-T-001 --clipboard-mode=bidirectional --drag-and-drop=bidirectional
@VBoxManage -q modifyvm WC10E-T-001 --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
:: VBoxManage -q sharedfolder add WC10E-T-001 --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/ubuntu/downloads"
:: 
:: Overzetten VDI naar VM Directory
if not exist "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\WC10E-T-001\WC10E-Trial.vdi" (
   copy "D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC10E-Trial.vdi" "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\WC10E-T-001"
) 
::
:: Virtual Hardisk voorzien van nieuwe UUID
@VBoxManage internalcommands sethduuid D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\WC10E-T-001\WC10E-Trial.vdi
::
:: VM Aanpassen zodat VDI wordt gebruikt 
@VBoxManage storageattach "WC10E-T-001" --storagectl "SATA" --port 0 --device 0 --type hdd --medium D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\WC10E-T-001\WC10E-Trial.vdi
::
:: STarten VM
:: VBoxManage -q --nologo startvm WC10E-T-001 --type=gui
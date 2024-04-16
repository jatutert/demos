:: Microsoft Windows Server 2019 Datacenter
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
:: 11 apr - Eerste versie van script gemaakt
:: 12 apr - Andere lokatie VHD en VDI bestanden 
::
:: :::: OPRUIMEN ::::
:: 
:: Stoppen eventueel draaiende virtuele machine
@VBoxManage -q controlvm WS19DC-T-001 poweroff
:: Verwijderen virtuele machine uit Oracle VM Virtualbox
@VBoxManage -q unregistervm WS19DC-T-001 --delete-all
:: Schoonmaken Oracle VM Virtualbox Medium lijst om foutmelding UUID te voorkomen 
@VBoxManage closemedium disk D:\Virtual-Machines\Templates\VirtualDisks\Windows\WS19DC-Trial.VHD >nul 2>&1
@VBoxManage closemedium disk D:\Virtual-Machines\Templates\VirtualDisks\Windows\WS19DC-Trial.vdi >nul 2>&1
:: Onderstaande melding zorgt voor foutmelding omdat VM niet meer bestaat 
@VBoxManage closemedium disk D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\WS19DC-T-001\WS19DC-Trial.vdi >nul 2>&1
:: 
:: :::: Bijwerken ::::
@VBoxManage -q updatecheck perform
@VBoxManage extpack cleanup
:: 
:: :::: Downloaden VHD ::::
::
:: Foutmelding No CAs were found in 'C:\ProgramData/ssl/ca-bundle.pem'
if not exist D:\Virtual-Machines\Templates\VirtualDisks\Windows\WS19DC-Trial.VHD (
   @wget2 -O D:\Virtual-Machines\Templates\VirtualDisks\Windows\WS19DC-Trial.VHD "https://go.microsoft.com/fwlink/p/?linkid=2195334&clcid=0x409&culture=en-us&country=us"
) 
::
:: Conversie VHD naar VDI
:: Oracle VM Virtualbox doet ook automatische registratie van zowel VMDK als VDI in Medium lijst
@VBoxManage.exe clonemedium disk --format=VDI "D:\Virtual-Machines\Templates\VirtualDisks\Windows\WS19DC-Trial.VHD" D:\Virtual-Machines\Templates\VirtualDisks\Windows\WS19DC-Trial.vdi
:: 
:: Create Virtual Machine
@VBoxManage createvm --name "WS19DC-T-001" --basefolder "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server" --default --ostype "Windows2019_64" --register 
::
:: Aanpassingen doen aan VM
@VBoxManage -q modifyvm WS19DC-T-001 --description="Windows Server 2019 DataCenter 180 days Trial"
@VBoxManage -q modifyvm WS19DC-T-001 --firmware=bios
@VBoxManage -q modifyvm WS19DC-T-001 --cpus=2
@VBoxManage -q modifyvm WS19DC-T-001 --memory=8192
@VBoxManage -q modifyvm WS19DC-T-001 --boot1=disk
@VBoxManage -q modifyvm WS19DC-T-001 --boot2=dvd
@VBoxManage -q modifyvm WS19DC-T-001 --boot3=none
@VBoxManage -q modifyvm WS19DC-T-001 --boot4=none
@VBoxManage -q modifyvm WS19DC-T-001 --audio-enabled=off
@VBoxManage -q modifyvm WS19DC-T-001 --clipboard-mode=bidirectional --drag-and-drop=bidirectional
@VBoxManage -q modifyvm WS19DC-T-001 --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
:: VBoxManage -q sharedfolder add WS19DC-T-001 --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/ubuntu/downloads"
:: 
:: Overzetten VDI naar VM Directory
copy "D:\Virtual-Machines\Templates\VirtualDisks\Windows\WS19DC-Trial.vdi" "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\WS19DC-T-001"
::
:: Virtual Hardisk voorzien van nieuwe UUID
@VBoxManage internalcommands sethduuid D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\WS19DC-T-001\WS19DC-Trial.vdi
::
:: Verwijderen VDI
del "D:\Virtual-Machines\Templates\VirtualDisks\Windows\WS19DC-Trial.vdi"
VBoxManage closemedium disk D:\Virtual-Machines\Templates\VirtualDisks\Windows\WS19DC-Trial.vdi
:: 
:: VM Aanpassen zodat VDI wordt gebruikt 
@VBoxManage storageattach "WS19DC-T-001" --storagectl "SATA" --port 0 --device 0 --type hdd --medium D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\WS19DC-T-001\WS19DC-Trial.vdi
::
:: STarten VM
:: VBoxManage -q --nologo startvm WS19DC-T-001 --type=gui
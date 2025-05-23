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
:: 26 apr - Gebruiken MS Development omgeving 
:: 
@ECHO OFF
@CLS
::
:: :::: OPRUIMEN ::::
::
@echo Opruimen eventueel aanwezige Machine ...  
:: Stoppen eventueel draaiende virtuele machine
@VBoxManage -q controlvm WC11E-T-001 poweroff
:: Verwijderen virtuele machine uit Oracle VM Virtualbox
@VBoxManage -q unregistervm WC11E-T-001 --delete-all
:: Schoonmaken Oracle VM Virtualbox Medium lijst om foutmelding UUID te voorkomen 
@VBoxManage closemedium disk %USERPROFILE%\Downloads\WinDev2404Eval-disk001.vmdk >nul 2>&1
:: Onderstaande melding zorgt voor foutmelding omdat VM niet meer bestaat 
@VBoxManage closemedium disk D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\WC11E-T-001\WC11E-T-001.vmdk >nul 2>&1
:: 
:: :::: Bijwerken ::::
:: @VBoxManage -q updatecheck perform
:: @VBoxManage extpack cleanup
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
:: 
if exist %USERPROFILE%\Downloads\WinDev2404Eval.VirtualBox.zip (
   @del %USERPROFILE%\Downloads\WinDev2404Eval.VirtualBox.zip
)
::
if exist %USERPROFILE%\Downloads\WinDev2404Eval.ova (
   @del %USERPROFILE%\Downloads\WinDev2404Eval.ova
)
::
if exist %USERPROFILE%\Downloads\WinDev2404Eval.ovf (
   @del %USERPROFILE%\Downloads\WinDev2404Eval.ovf
)
::
::
@echo Downloaden Virtuele Machine bij Microsoft
@echo Dit duurt enige minuten ... 
:: Foutmelding No CAs were found in 'C:\ProgramData/ssl/ca-bundle.pem'
:: Omvang 23 GB 23 201 160 423 ZIP BESTAND 
@wget2 -O %USERPROFILE%\Downloads\WinDev2404Eval.VirtualBox.zip https://aka.ms/windev_VM_virtualbox >nul 2>&1
::
:: #### Uitpakken ZIP Bestand
:: Resultaat is OVA-bestand 
@echo Uitpakken ZIP bestand naar OVA bestand 
c:\PROGRA~1\7-Zip\7z x -bd -y -o"%USERPROFILE%\Downloads" "%USERPROFILE%\Downloads"\WinDev2404Eval.VirtualBox.zip >nul 2>&1
::
:: #### Verwijderen ZIP om ruimte te sparen 
@TIMEOUT /T 60 /NOBREAK
@del %USERPROFILE%\Downloads\WinDev2404Eval.VirtualBox.zip
::
:: ##### Uitpakken OVA Bestand
:: Resultaat is VMDK en OVF bestand 
:: Naam VMDK is WinDev2404Eval-disk001.VMDK
@echo Uitpakken OVA bestand naar VMDK bestand 
@c:\PROGRA~1\7-Zip\7z x -bd -y -o"%USERPROFILE%\Downloads" "%USERPROFILE%\Downloads"\WinDev2404Eval.ova
::
:: #### Verwijderen OVA om ruimte te sparen 
:: Resultaat is VMDK en OVF bestand 
@TIMEOUT /T 60 /NOBREAK
@del %USERPROFILE%\Downloads\WinDev2404Eval.ova
@del %USERPROFILE%\Downloads\WinDev2404Eval.ovf
::
::
::
:: Conversie VHD naar VDI
:: Oracle VM Virtualbox doet ook automatische registratie van zowel VMDK als VDI in Medium lijst
:: @VBoxManage.exe clonemedium disk --format=VDI "D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC11E-VHLK-Trial.VHDX" D:\Virtual-Machines\Templates\VirtualDisks\Windows\WC11E-VHLK-Trial.vdi
::
:: Conversie VMDK naar VDI 
:: Overbodig omdat VirtualBOX VMDK ondersteuning heeft 
:: @VBoxManage.exe clonemedium disk --format=VDI "%USERPROFILE%\Downloads\WinDev2404Eval-disk001.VMDK" %USERPROFILE%\Downloads\WinDev2404Eval-disk001.vdi
::
::
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
:: Overzetten VMDK naar VM Directory
@echo Overzetten VMDK bestand naar locatie Virtuele Machine 
@copy "%USERPROFILE%\Downloads\WinDev2404Eval-disk001.vmdk" "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\WC11E-T-001\WC11E-T-001.vmdk"
::
:: Virtual Hardisk voorzien van nieuwe UUID
@echo Aanpassen UUID van VMDK om uniek te maken ... 
@VBoxManage internalcommands sethduuid D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\WC11E-T-001\WC11E-T-001.vmdk >nul 2>&1
::
:: Verwijderen VMDK uit Downloads 
@del "%USERPROFILE%\Downloads\WinDev2404Eval-disk001.vmdk"
@VBoxManage closemedium disk %USERPROFILE%\Downloads\WinDev2404Eval-disk001.vmdk >nul 2>&1
::
:: VM Aanpassen zodat VDI wordt gebruikt 
@echo Koppelen VMDK aan Virtuele Machine ... 
@VBoxManage storageattach "WC11E-T-001" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\WC11E-T-001\WC11E-T-001.vmdk"
::
:: STarten VM
:: VBoxManage -q --nologo startvm WC11E-T-001 --type=gui
::
:: SSH staat niet aan !
:: VBoxManage guestcontrol WC11E-T-001 run --username=User "winget update"
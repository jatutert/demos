::
::
::
::
:: OSTicket Virtualbox Demo Configuration Script
:: Version 0.0.6
:: 
:: Date July 18 2024
:: Author John Tutert
::
::
::
:: 
:: :::: Configuratie SHELL voor dit script
@echo off
@cls
::
@rem :::: Welkomstbericht tonen aan gebruiker
@echo OSTicket Demo Auto Configurator 
@echo. 
@echo Hpervisor: Oracle VM Virtualbox
@echo Vagrant Box: Vagrant generic/ubuntu2204
@echo Operating Systems virtual machine: Ubuntu 24.04 LTS
@echo. 
@echo Developed by John Tutert
@echo.
@echo For Personal and/or Education use only !  
@echo. 
::
@rem :::: Definitie variabelen voor dit script
::
@rem :: Variabelen voor VAGRANT
@echo Definitie variabelen voor HashiCorp Vagrant ...
::
@rem 	Linux Gebruiker
set OSTICKET_DEMO_VAGRANT_LNX_USER=vagrant
@rem 	Versienummer Vagrant box 
set OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VER=2404.0.2405
@rem 	Locatie Vagrant Box harddisk template
set OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VM_DIR="%USERPROFILE%\.vagrant.d\boxes\gusztavvargadr/ubuntu-server-2404-lts\%OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VER%\amd64\vmware_desktop"
set OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VB_DIR="%USERPROFILE%\.vagrant.d\boxes\gusztavvargadr/ubuntu-server-2404-lts\%OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VER%\amd64\virtualbox"
@rem	Naam virtuele harddisk VDMK template 
set OSTICKET_DEMO_VAGRANT_HDU_VB_VMDK=packer-20240610-092843-disk001.vmdk
set OSTICKET_DEMO_VAGRANT_HDU_VB_VDI=generic-ubuntu2204-virtualbox-x64-disk001.vdi
set OSTICKET_DEMO_VAGRANT_HDU_VM_VMDK=generic-ubuntu2204-vmware-x64.vmdk
::
::	:: PATH aanvullen voor Oracle VM Virtualbox
@echo Check aanwezigheid van Oracle VM Virtualbox in PATH variable 
::
@VBoxManage --version >nul 2>&1
::
::	Onderstaande lus WERKT NIET
::	Foutmelding
::	\VMware\VMware
::
::	if %errorlevel% neq 0 (
::		set pathEnv=%PATH%
::		set vboxPath="C:\Program Files\Oracle\VirtualBox\"
::		set newPathEnv=%pathEnv%;%vboxPath%
::		setx PATH "%newPathEnv%"
::	) else (
::		echo Oracle VM Virtualbox VBoxManage is present ! Let's carry on .. >nul 2>&1
::	)
::
::
:: :: Varibelen voor Oracle VM Virtualbox 
::
:: 	Standaard locatie virtuele machines Virtualbox op deze laptop 
set VIRTBOX_VIRTMACH_DIR="D:\Virtual-Machines\Oracle-VM-Virtualbox"
::
::	## Template 
::
:: 	Locatie virtuele harddisk template 
set VIRT_MACHINES_TEMPLATE_DIRECTORY="D:\Virtual-Machines\Templates\VirtualDisks\Linux"
::
::
:: ## Virtual machine
@echo Definitie variabelen voor virtuele machines ... 
::
:: 	Locatie waar virtuele machine opgeslagen moeten worden 
set OSTICKET_DEMO_VM_DIRECTORY="D:\Virtual-Machines\Oracle-VM-Virtualbox\Linux\OSTicket-Demo"
@rem	Type virtuele machine 
set DOCKER_DEMO_VM_TYPE=controller
@rem	Hostname
set OSTICKET_DEMO_WEBSRV_HOSTNAME=u24-lts-s-wsrv-001
set OSTICKET_DEMO_DBSRV_HOSTNAME=u24-lts-s-dbms-001
@rem	Poort SSH
set OSTICKET_DEMO_VM_CNTRL_SSH_PORT=3001
set OSTICKET_DEMO_VM_H10_SSH_PORT=3002
::
::
:: :::: Controle Benodigheden voor dit Script
::
@echo #### Controle Benodigheden voor OSTicket DEMO omgeving 
::
::
:: [IBM/HashiCorp Vagrant]
vagrant version >nul 2>&1
if %errorlevel% neq 0 (
:: Vagrant is NIET geïnstalleerd, installeer het
    @echo Hashicorp Vagrant is NOT installed ! 
	@echo Starting install ... 
	@winget install --id Hashicorp.Vagrant --accept-package-agreements --accept-source-agreements >nul 2>&1
	@echo Hasicorp Vagrant installation done ... 
	@echo Please restart script ! 
	@pause
	@exit /B 0
) else (
    :: Vagrant is geïnstalleerd, werk het bij
    :: winget upgrade --id Hashicorp.Vagrant --accept-package-agreements --accept-source-agreements >nul 2>&1
	echo Hashicorp Vagrant is present ! Let's carry on .. >nul 2>&1
)
::
::
:: [Oracle VM Virtualbox]
winget list -e --id Oracle.VirtualBox >nul 2>&1
if %errorlevel% neq 0 (
    :: Oracle.Virtualbox is NIET geïnstalleerd, installeer het
    @echo Oracle VM Virtualbox is NOT installed ! 
	@echo Starting install ... 
	@winget install --id Oracle.VirtualBox --accept-package-agreements --accept-source-agreements >nul 2>&1
	@echo please restart script !
	@pause
	@exit /B 0 
) else (
    :: Oracle.Virtualbox  is geïnstalleerd, werk het bij
    echo Oracle VM Virtualbox is present ! >nul 2>&1
	winget upgrade --id Oracle.VirtualBox --accept-package-agreements --accept-source-agreements >nul 2>&1
)
::
::
:: [7-ZIP]
winget list -e --id 7zip.7zip >nul 2>&1
if %errorlevel% neq 0 (
    :: 7zip.7zip is NIET geïnstalleerd, installeer het
    winget install --id 7zip.7zip --accept-package-agreements --accept-source-agreements >nul 2>&1
) else (
    :: 7zip.7zip is geïnstalleerd, werk het bij
    winget upgrade --id 7zip.7zip --accept-package-agreements --accept-source-agreements >nul 2>&1
)
::
::
::	:: [cURL.cURL] 
::	winget list -e --id cURL.cURL >nul 2>&1
::	if %errorlevel% neq 0 (
::		:: cURL.cURL is NIET geïnstalleerd, installeer het
::	    winget install --id cURL.cURL --accept-package-agreements --accept-source-agreements >nul 2>&1
::	) else (
::		:: cURL.cURL is geïnstalleerd, werk het bij
::		winget upgrade --id cURL.cURL --accept-package-agreements --accept-source-agreements >nul 2>&1
::	)
::
::
::	:: [CYGWIN]
:: 
::	if not exist C:\cygwin64\bin\sed.exe (
::		del %USERPROFILE%\Downloads\setup-x86_64.exe
::		curl -s -o %USERPROFILE%\Downloads\setup-x86_64.exe https://www.cygwin.com/setup-x86_64.exe
::		:: https://www.cygwin.com/faq/faq.html#faq.setup.cli
::		start /D %HOMEPATH% /I /B /MAX %USERPROFILE%\Downloads\setup-x86_64.exe --quiet-mode --download --local-install --no-verify --local-package-dir "%USERPROFILE%\Downloads" --root "C:\cygwin64"
::		)
::
::
::	:: [sshpass]
::
::	@del /F %userprofile%\sshpass.exe
::	@wget2 -O %userprofile%\sshpass.exe https://github.com/xhcoding/sshpass-win32/releases/download/v1.0.1/sshpass.exe
::
::
@echo #### Make Vagrant ready for use
::
::	:::: VAGRANT BOXES downloaden en bijwerken 
::
:: 	Vagrant box ubuntu 2404 LTS download
:: 	Toevoegen generic/ubuntu2204 box versie 4.3.12 indien niet aanwezig  
::	https://developer.hashicorp.com/vagrant/docs/cli/box#box-add
@vagrant box add gusztavvargadr/ubuntu-server-2404-lts --box-version %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VER% --clean --provider virtualbox >nul 2>&1
:: @vagrant box add gusztavvargadr/ubuntu-server-2404-lts --box-version %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VER% --clean --provider vmware_desktop >nul 2>&1
:: 
:: 	@vagrant box list -i generic/ubuntu2204 >nul 2>&1
::
:: 	Vagrant box ubuntu 2404 LTS updaten
@vagrant box update --box gusztavvargadr/ubuntu-server-2404-lts --provider virtualbox >nul 2>&1
:: @vagrant box update --box gusztavvargadr/ubuntu-server-2404-lts --provider vmware_desktop >nul 2>&1
:: 	Vagrant box ubuntu 2404 LTS opschonen
@vagrant box prune >nul 2>&1
::  
:: 	:::: Opruimen voordat we kunnen starten 
:: 
:: 	Verwijderen HOSTS bestand binnen userprofile directory 
@copy /Y %USERPROFILE%\.ssh\known_hosts %USERPROFILE%\.ssh\known_hosts_docker_demo.bck
@del /F %USERPROFILE%\.ssh\known_hosts >nul 2>&1
::
:: :::: Stoppen eventueel draaiende virtuele machines   
@VBoxManage -q controlvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% poweroff >nul 2>&1
@VBoxManage -q controlvm %OSTICKET_DEMO_DBSRV_HOSTNAME% poweroff >nul 2>&1
:: 
:: :::: Verwijderen eventueel aanwezige virtuele machines  
@VBoxManage -q unregistervm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --delete-all >nul 2>&1
@VBoxManage -q unregistervm %OSTICKET_DEMO_DBSRV_HOSTNAME% --delete-all >nul 2>&1
:: 
::	::::	Schoonmaken medium list Oracle VM Virtualbox
::
:: 	::		Template directory VMDK
@VBoxManage closemedium disk %VIRT_MACHINES_TEMPLATE_DIRECTORY%\%OSTICKET_DEMO_VAGRANT_HDU_VB_VMDK% >nul 2>&1
::
::
:: Template directory VDI
:: @VBoxManage closemedium disk %VIRT_MACHINES_TEMPLATE_DIRECTORY%\%OSTICKET_DEMO_VDI_TEMPLATE_FILE% >nul 2>&1
:: Vagrant VMDK 
:: @VBoxManage closemedium disk %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VB_DIR%\%OSTICKET_DEMO_VAGRANT_HDU_VB_VMDK% >nul 2>&1
:: Virtuele machine 
:: @VBoxManage closemedium disk %OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%\%OSTICKET_DEMO_VAGRANT_HDU_VB_VMDK% >nul 2>&1
:: @VBoxManage closemedium disk %OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_DBSRV_HOSTNAME%\%OSTICKET_DEMO_VAGRANT_HDU_VB_VMDK% >nul 2>&1
:: @VBoxManage closemedium disk %OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_VM_H11_HOSTNAME%\%OSTICKET_DEMO_VAGRANT_HDU_VB_VMDK% >nul 2>&1
::
::
:: #### Conversie bestaande Vagrant Generic/Ubuntu 22.04 Virtual harddisk van VMDK naar VDI ####
:: :: LET OP Oracle VM Virtualbox doet ook automatische registratie van zowel VMDK als VDI in Medium lijst
:: @del "%VIRT_MACHINES_TEMPLATE_DIRECTORY%\%OSTICKET_DEMO_VDI_TEMPLATE_FILE%" >nul 2>&1
:: @echo VDI Clone maken van bestaande VMDK ... 
::
::
:: :::: Alles is schoon .. we kunnen beginnen ... 
:: 
:: :::: Directory voor virtuele machines maken 
:: 
@mkdir "%OSTICKET_DEMO_VM_DIRECTORY%"\ >nul 2>&1
::
:: :::: Aanmaken virtuele machines in Oracle VM Virtualbox 
::
::	VBoxManage list ostypes voor opvragen lijst ostypes virtualbox 
::	Versie 24 is nog niet beschikbaar dus laten we op versie 22 staan 
::
@VBoxManage createvm --name "%OSTICKET_DEMO_WEBSRV_HOSTNAME%" --basefolder "%OSTICKET_DEMO_VM_DIRECTORY%" --default --ostype "Ubuntu22_LTS_64" --register >nul 2>&1
@VBoxManage createvm --name "%OSTICKET_DEMO_DBSRV_HOSTNAME%" --basefolder "%OSTICKET_DEMO_VM_DIRECTORY%" --default --ostype "Ubuntu22_LTS_64" --register >nul 2>&1
::
:: :::: Settings aanpassen van de nieuwe virtuele machines 
::
:: :: Webserver
::
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --description="Ubuntu 24.04 LTS (gusztavvargadr/ubuntu-server-2404-lts) OSTicket Webserver"
:: EFI uitzetten 
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --firmware=efi64
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --cpus=2
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --memory=2048
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --vram 256
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --boot1=disk
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --boot2=dvd
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --boot3=none
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --boot4=none
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --audio-enabled=off
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --clipboard-mode=bidirectional --drag-and-drop=bidirectional
@VBoxManage -q modifyvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
@VBoxManage -q sharedfolder remove %OSTICKET_DEMO_WEBSRV_HOSTNAME% --name="downloads" >nul 2>&1
@VBoxManage -q sharedfolder add %OSTICKET_DEMO_WEBSRV_HOSTNAME% --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/%OSTICKET_DEMO_VAGRANT_LNX_USER%/downloads"
::
:: :: DBMS Server
::
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --description="Ubuntu 24.04 LTS (gusztavvargadr/ubuntu-server-2404-lts) OSTicket DBMS"
:: EFI uitzetten 
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --firmware=efi64
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --cpus=2
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --memory=2048
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --vram 256
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --boot1=disk
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --boot2=dvd
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --boot3=none
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --boot4=none
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --audio-enabled=off
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --clipboard-mode=bidirectional --drag-and-drop=bidirectional
@VBoxManage -q modifyvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2="VirtualBox Host-Only Ethernet Adapter"
@VBoxManage -q sharedfolder remove %OSTICKET_DEMO_DBSRV_HOSTNAME% --name="downloads" >nul 2>&1
@VBoxManage -q sharedfolder add %OSTICKET_DEMO_DBSRV_HOSTNAME% --name="downloads" --hostpath="%USERPROFILE%\Downloads" --automount --auto-mount-point="/home/%OSTICKET_DEMO_VAGRANT_LNX_USER%/downloads"
::
::
:: :::: Nieuwe virtuele machines voorzien van virtuele harde schijven
@echo Virtuele machines voorzien van virtuele harddisks ... 
:: 
:: :: Clone maken van Vagrant generic/ubuntu2204 vmdk bestand naar vdi bestand 
::
@VBoxManage.exe clonemedium disk --format=VDI %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VB_DIR%\%OSTICKET_DEMO_VAGRANT_HDU_VB_VMDK% %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VB_DIR%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%.VDI >nul 2>&1
@VBoxManage.exe clonemedium disk --format=VDI %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VB_DIR%\%OSTICKET_DEMO_VAGRANT_HDU_VB_VMDK% %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VB_DIR%\%OSTICKET_DEMO_DBSRV_HOSTNAME%.VDI >nul 2>&1
::
:: :: Overzetten nieuwe VDI virtuele harde schijven naar directories van de virtuele machines 
::
:: Webserver
@copy /Y %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VB_DIR%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%.VDI "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%" >nul 2>&1
:: @del %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VB_DIR%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%.VDI 
@@VBoxManage closemedium disk %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VB_DIR%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%.VDI --delete >nul 2>&1
:: DBMS server
@copy /Y %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VB_DIR%\%OSTICKET_DEMO_DBSRV_HOSTNAME%.VDI "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_DBSRV_HOSTNAME%" >nul 2>&1
:: @del %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VM_DIR%\%OSTICKET_DEMO_DBSRV_HOSTNAME%.VDI
@@VBoxManage closemedium disk %OSTICKET_DEMO_VAGRANT_HDU_TEMPLATE_VB_DIR%\%OSTICKET_DEMO_DBSRV_HOSTNAME%.VDI --delete >nul 2>&1
::
:: ## Virtual Hardisk voorzien van nieuwe UUID
:: 
:: @VBoxManage internalcommands sethduuid "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%.VMDK"
:: @VBoxManage internalcommands sethdparentuuid "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%.VMDK"
:: 
:: @VBoxManage internalcommands sethduuid "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_DBSRV_HOSTNAME%\%OSTICKET_DEMO_DBSRV_HOSTNAME%.VMDK"
:: @VBoxManage internalcommands sethdparentuuid "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_DBSRV_HOSTNAME%\%OSTICKET_DEMO_DBSRV_HOSTNAME%.VMDK"
::
:: @VBoxManage internalcommands sethduuid %OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_VM_H11_HOSTNAME%\%OSTICKET_DEMO_VAGRANT_HDU_VB_VMDK% >nul 2>&1
::
:: :: Attach van nieuwe VDI virtuele schijf aan de virtuele machines  
::
:: Webserver
@VBoxManage storageattach "%OSTICKET_DEMO_WEBSRV_HOSTNAME%" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%\%OSTICKET_DEMO_WEBSRV_HOSTNAME%.VDI"
:: DBMS
@VBoxManage storageattach "%OSTICKET_DEMO_DBSRV_HOSTNAME%" --storagectl "SATA" --port 0 --device 0 --type hdd --medium "%OSTICKET_DEMO_VM_DIRECTORY%\%OSTICKET_DEMO_DBSRV_HOSTNAME%\%OSTICKET_DEMO_DBSRV_HOSTNAME%.VDI"
::
:: :::: Nieuw gemaakte virtuele machines starten in Oracle VM Virtualbox 
::
@echo #### Starten OSTicket DEMO virtuele machines 
:: 
@echo 3 Minuten wachten totdat Oracle VM Virtualbox zover is ... 
sleep 180
@VBoxManage -q --nologo startvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% --type=gui >nul 2>&1
::
@echo 4 Minuten wachten op start van webserver virtuele machine   
sleep 240
@VBoxManage -q --nologo startvm %OSTICKET_DEMO_DBSRV_HOSTNAME% --type=gui >nul 2>&1
::
@echo 3 minuten wachten op start van DBMS server virtuele machine  
sleep 180
::
::
::
:: :::: De virtuele machhine zijn draaiend binnen Oracle VM Virtualbox 
::
::
:: 
:: :::: Virtuele Machine PORT Forwarding Instellen 
::
@ECHO #### Configuratie PortForwarding op NAT interface ...
:: DOCKER Controller ulx-s-2204-d-srvr
@VBoxManage -q controlvm %OSTICKET_DEMO_WEBSRV_HOSTNAME% natpf1 guestssh,tcp,,%OSTICKET_DEMO_VM_CNTRL_SSH_PORT%,,22
@VBoxManage -q controlvm %OSTICKET_DEMO_DBSRV_HOSTNAME% natpf1 guestssh,tcp,,%OSTICKET_DEMO_VM_H10_SSH_PORT%,,22
::
::
:: RSA sleutel genereren zonder verdere vragen aan de gebruiker 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
:: ssh-keygen -f id_rsa -t rsa -N ""
:: copy /Y id_rsa %USERPROFILE%\.ssh
:: copy /Y id_rsa.pub %USERPROFILE%\.ssh
::
::
:: RSA sleutel overzetten naar virtuele machine 
:: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
:: SSH-COPY-ID binnen Windows mbv Python
:: zie https://pypi.org/project/sshcopyid/
::
::
:: Er wordt gevraagd om wachtwoord 
:: https://superuser.com/questions/1747549/alternative-to-ssh-copy-id-on-windows
::
::
::
::
:: 	VBoxManage guestcontrol <uuid | vmname> copyto [--dereference] [--domain=domainname] [--passwordfile=password-file
::     | --password=password] [--quiet] [--no-replace] [--recursive] [--target-directory=guest-destination-dir]
::     [--update] [--username=username] [--verbose] <host-source0> host-source1 [...]
::
::  VBoxManage guestcontrol <uuid | vmname> run [--arg0=argument 0] [--domain=domainname] [--dos2unix] [--exe=filename]
::     [--ignore-orphaned-processes] [--no-wait-stderr | --wait-stderr] [--no-wait-stdout | --wait-stdout]
::     [--passwordfile=password-file | --password=password] [--profile] [--putenv=var-name=[value]] [--quiet]
::     [--timeout=msec] [--unix2dos] [--unquoted-args] [--username=username] [--verbose] <-- [argument...] >
::
:: 
::
::
:: 
::	:::: 	RSA keys overzetten naar virtuele machine 
@VBoxManage guestcontrol %OSTICKET_DEMO_WEBSRV_HOSTNAME% copyto --username=%OSTICKET_DEMO_VAGRANT_LNX_USER% --password=%OSTICKET_DEMO_VAGRANT_LNX_USER% --target-directory=/home/%OSTICKET_DEMO_VAGRANT_LNX_USER%/.ssh/authorized_keys %USERPROFILE%\.ssh\id_rsa.pub
@VBoxManage guestcontrol %OSTICKET_DEMO_DBSRV_HOSTNAME% copyto --username=%OSTICKET_DEMO_VAGRANT_LNX_USER% --password=%OSTICKET_DEMO_VAGRANT_LNX_USER% --target-directory=/home/%OSTICKET_DEMO_VAGRANT_LNX_USER%/.ssh/authorized_keys %USERPROFILE%\.ssh\id_rsa.pub
:: 
::
::	:::: 	Ubuntu autoupgrade uitzetten in virtuele machine
::
::	NIET MEER NODIG IN VERSIE 24.04 of zit ergens anders
:: 	@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% -o StrictHostKeyChecking=no sudo sed 's@"1"@"0"@' -i /etc/apt/apt.conf.d/20auto-upgrades
::	@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% -o StrictHostKeyChecking=no sudo sed 's@"1"@"0"@' -i /etc/apt/apt.conf.d/20auto-upgrades
:: 
::
::	::::	Configuratie DNS ivm EduRoam
::
::	Webserver
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% sudo sed "s@4.2.2.1@145.76.2.75@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% sudo sed "s@4.2.2.2@145.76.2.85@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% sudo sed "s@208.67.220.220@145.2.14.10, 8.8.8.8, 8.8.4.4@" -i /etc/netplan/01-netcfg.yaml
@ssh -i  %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% sudo netplan apply
::	DBMS server
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% sudo sed "s@4.2.2.1@145.76.2.75@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% sudo sed "s@4.2.2.2@145.76.2.85@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% sudo sed "s@208.67.220.220@145.2.14.10, 8.8.8.8, 8.8.4.4@" -i /etc/netplan/01-netcfg.yaml
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% sudo netplan apply
::
::	::::	Configuratie ETH1 netwerkkaart in virtuele machine 
::
::	Webserver
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo curl -s -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/demos/main/Docker/Virtualbox/Linux/Netplan/00-installer-config.yaml"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo netplan apply"
:: 
::	DBMS server
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo curl -s -o /etc/netplan/00-installer-config.yaml https://raw.githubusercontent.com/jatutert/demos/main/Docker/Virtualbox/Linux/Netplan/00-installer-config.yaml"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo netplan apply"
:: 
::	::::	Aanpassen hostname zonder herstart Verandering is zichtbaar na uitloggen en dan weer inloggen 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% sudo hostnamectl set-hostname %OSTICKET_DEMO_WEBSRV_HOSTNAME%
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% sudo hostnamectl set-hostname %OSTICKET_DEMO_DBSRV_HOSTNAME%
::
::	::::	Aanpassen Ubuntu Repository 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% sudo sed 's@mirrors.edge.kernel.org@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% sudo sed 's@mirrors.edge.kernel.org@nl.archive.ubuntu.com@' -i /etc/apt/sources.list
:: 
::	::::	Updaten Ubuntu Repository
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo apt update -qq" >nul 2>&1
:: @ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo apt-get update -qq" >nul 2>&1
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo apt update -qq" >nul 2>&1
:: @ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo apt-get update -qq" >nul 2>&1
::
::	::::	Upgraden Ubuntu
@echo Ubuntu 22.04 LTS Bijwerken ... 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo apt upgrade -y "
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo apt upgrade -y "
::
::	::::	Ubuntu Verwijderen overbodige zaken
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo apt autoremove -y"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo apt autoremove -y"
::
::	::::	SNAP bijwerken
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo snap refresh"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo snap refresh"
::
::	::::	Curl bijwerken
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo snap install curl --channel=latest"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo snap install curl --channel=latest"
::
::	::::	Installatie Cockpit binnen Ubuntu
@echo Installatie Cockpit binnen Ubuntu .. Later te benaderen via poort 9090
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo apt-get install cockpit -y"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo systemctl enable --now cockpit.socket"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo apt-get install cockpit -y"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo systemctl enable --now cockpit.socket"
::
::	::::	Downloaden Ubuntu Config script vanaf Github JA Tutert
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo curl -s -o /home/vagrant/ubuntu-config-latest.sh https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/ubuntu-config-latest.sh"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo chmod +x /home/vagrant/ubuntu-config-latest.sh"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo curl -s -o /home/vagrant/ubuntu-config-latest.sh https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/ubuntu-config-latest.sh"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo chmod +x /home/vagrant/ubuntu-config-latest.sh"
::
::	::::	Downloaden Introductie Infrastructuren scripts vanaf github 
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "curl -s -o /home/vagrant/install-mysqlserver.sh https://raw.githubusercontent.com/jatutert/demos/main/OSTicket/Ubuntu/install-mysqlserver.sh"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "curl -s -o /home/vagrant/install-webserver-UB22.sh https://raw.githubusercontent.com/jatutert/demos/main/OSTicket/Ubuntu/install-webserver-UB22.sh"
::
::	::::	Uitvoerbaar maken Introductie Infrastructuren scripts
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo chmod +x /home/vagrant/install-mysqlserver.sh"
@ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo chmod +x /home/vagrant/install-webserver-UB22.sh"
:: 
:: #### Uitvoeren Introductie Infrastructuren scripts
@echo Uitvoeren Ubuntu configuratiescript gestart ... 
::
:: Staat UIT omdat de goede links en scripts nog niet op github staan 
:: 
:: @ ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_CNTRL_SSH_PORT% "sudo /home/vagrant/install-mysqlserver.sh"
:: @ ssh -i %USERPROFILE%\.ssh\id_rsa %OSTICKET_DEMO_VAGRANT_LNX_USER%@127.0.0.1 -p %OSTICKET_DEMO_VM_H10_SSH_PORT% "sudo /home/vagrant/install-webserver-UB22.sh"
::
::
::  
:: 
@echo Ga naar virtuele machine
@echo via
@echo @ssh -i %USERPROFILE%\.ssh\id_rsa vagrant@127.0.0.1 -p 3001
::
::
::
:: Thats all folks
::
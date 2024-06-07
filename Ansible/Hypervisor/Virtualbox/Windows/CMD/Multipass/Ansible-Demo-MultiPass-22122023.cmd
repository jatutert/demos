:: 
:: Canonical MultiPASS Ansible DEMO Script
:: Version 1.00 
:: Date December 22 2023 
:: Author John Tutert
::
@ECHO OFF
@CLS
:: 
@ECHO Canonical Multipass Ansible DEMO Script 
@ECHO.  
@ECHO Fase 1 // Installatie of Updaten GESTART ... 
@ECHO. 
@ECHO Oracle Virtualbox
winget list -e --id Oracle.VirtualBox >nul 2>&1
if %errorlevel% neq 0 (
   winget install --id Oracle.VirtualBox --accept-package-agreements --accept-source-agreements
   ) else (
   winget update --id Oracle.VirtualBox --accept-package-agreements --accept-source-agreements
)
@ECHO Canonical Multipass
winget list -e --id Canonical.Multipass >nul 2>&1
if %errorlevel% neq 0 (
   winget install --id Canonical.Multipass --accept-package-agreements --accept-source-agreements
   ) else (
   winget update --id Canonical.Multipass --accept-package-agreements --accept-source-agreements
)
@ECHO Sysinternals Suite
:: Installatie/Updaten SysInternals Suite vanwege PSExec tool 
:: Reden PSExec: Multipass draait alles onder SYSTEM account :: Zie https://jon.sprig.gs/blog/post/1574
winget list -e --id 9P7KNL5RWT25 >nul 2>&1
if %errorlevel% neq 0 (
   winget install --id 9P7KNL5RWT25 --accept-package-agreements --accept-source-agreements
   ) else (   
   winget update --id 9P7KNL5RWT25 --accept-package-agreements --accept-source-agreements   
)
@ECHO. 
@ECHO Fase 2 // Virtuele Machine maken binnen Virtualbox gestart ... 
@ECHO. 
@ECHO Verwijderen eventuel aanwezige (oude) Ansible DEMO virtuele machines
:: Ansible Controller
Multipass delete ulx-s-2204-l-a-001
:: Ansible Host
Multipass delete ulx-s-2204-l-a-010
:: 
@ECHO 30 seconden wachten ... 
:: nobreak bij timeout is geen melding press key // t = tijd in seconden 
timeout -T 30 /NOBREAK
:: Purgen van alle verwijderde vms 
@ECHO Multipass purge uitvoeren 
Multipass purge 
:: Wachten op purge
@ECHO 30 seconden wachten ...  
:: nobreak bij timeout is geen melding press key // t = tijd in seconden 
timeout -T 30 /NOBREAK
::
@ECHO Multipass STARTEN Virtuele Machine ulx-s-2204-l-d-010
:: Starten VM met eigen gekozen naam cpu memory settings 
:: Ansible Controller
@multipass launch lts --name ulx-s-2204-l-a-001 --cpus 2 --memory 8192M
:: Ansible Host 
@multipass launch lts --name ulx-s-2204-l-a-010 --cpus 2 --memory 8192M
::
:: Wachten op voltooien van het starten 
:: Alleen wachten geen melding press key voor gebruiker door NOBREAK parameter
timeout -T 60 /NOBREAK
::
:: stoppen vm :: lijkt niet nodig te zijn omdat modifyvm werk op draaiende vm 
:: multipass stop ulx-s-2204-l-d-010
:: 
:: AANPASSEN VM
::
:: [OPTIE 1]
:: :: VirtualBOX Poorten open zetten poorten extern (host) en dan intern (guest) 
:: https://superuser.com/questions/901422/virtualbox-command-line-setting-up-port-forwarding
:: modifyvm = indien vm niet run
:: controlvm = indien vm runing 
::
:: https://docs.oracle.com/en/virtualization/virtualbox/7.0/user/vboxmanage.html#vboxmanage-modifyvm-general
:: 
:: psexec "c:\program files\oracle\virtualbox\vboxmanage" controlvm "ulx-s-2204-l-d-010" --nat-pf1="portainer,tcp,,9000,,9000"
:: psexec "c:\program files\oracle\virtualbox\vboxmanage" controlvm "ulx-s-2204-l-d-010" --nat-pf1="guestssh,tcp,,2222,,22"
::
:: [OPTIE 2]
:: Toevoegen NIC 2 Host-Only aan VM 
:: Getest 21 dec 2023 WERKT
@ECHO VBoxManage NIC2 toevoegen aan ulx-s-2204-l-d-010 
:: Getest 22 december 2023 1734 uur door John WERKT 
:: Nummers achter nic nictype e.d moet gelijk zijn 
psexec "c:\program files\oracle\virtualbox\vboxmanage" modifyvm "ulx-s-2204-l-a-001" --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2 "VirtualBox Host-Only Ethernet Adapter"
psexec "c:\program files\oracle\virtualbox\vboxmanage" modifyvm "ulx-s-2204-l-a-010" --nic2=hostonly --nictype2=82540EM --nic-promisc2=allow-all --cableconnected2=on --hostonlyadapter2 "VirtualBox Host-Only Ethernet Adapter"
::
:: Netwerkkaart 2 op DHCP Instellen 
@ECHO Multipass Netwerkconfiguratie ubuntu aanpassen  
multipass exec ulx-s-2204-l-a-001 -- sudo netplan set ethernets.enp0s8.dhcp4=true
multipass exec ulx-s-2204-l-a-001 -- sudo netplan apply
::
multipass exec ulx-s-2204-l-a-010 -- sudo netplan set ethernets.enp0s8.dhcp4=true
multipass exec ulx-s-2204-l-a-010 -- sudo netplan apply
::
:: Ubuntu Repository aanpassen naar NL 
@ECHO Ubuntu Repository aanpassen naar Nederland 
multipass exec ulx-s-2204-l-a-001 -- sudo sed "s@archive.ubuntu.com@nl.archive.ubuntu.com@" -i /etc/apt/sources.list
multipass exec ulx-s-2204-l-a-010 -- sudo sed "s@archive.ubuntu.com@nl.archive.ubuntu.com@" -i /etc/apt/sources.list
::
:: Ubuntu Repository bijwerken naar laatste stand van zaken
@ECHO Installatie cURL binnen ulx-s-2204-l-d-010
multipass exec ulx-s-2204-l-a-001 -- sudo apt update >nul 2>&1
multipass exec ulx-s-2204-l-a-010 -- sudo apt update >nul 2>&1
::
multipass exec ulx-s-2204-l-a-001 -- sudo snap install curl >nul 2>&1
multipass exec ulx-s-2204-l-a-010 -- sudo snap install curl >nul 2>&1
::
@ECHO Downloaden Docker DEMO configuratie script vanaf GitHUB
:: multipass exec ulx-s-2204-l-a-001 -- curl -s -o /home/ubuntu/ubuntu-dckr-demo-config-latest.sh https://raw.githubusercontent.com/jatutert/docker-demos/main/ubuntu-dckr-demo-config-latest.sh
:: multipass exec ulx-s-2204-l-a-001 -- sudo chmod +x /home/ubuntu/ubuntu-dckr-demo-config-latest.sh
::
:: multipass exec ulx-s-2204-l-a-010 -- curl -s -o /home/ubuntu/ubuntu-dckr-demo-config-latest.sh https://raw.githubusercontent.com/jatutert/docker-demos/main/ubuntu-dckr-demo-config-latest.sh
:: multipass exec ulx-s-2204-l-a-001 -- sudo chmod +x /home/ubuntu/ubuntu-dckr-demo-config-latest.sh
::
:: Ubuntu update en Docker-CE installeren (inclusief Compose plugin) 
@ECHO Uitvoeren Docker DEMO configuratie script binnen ulx-s-2204-l-d-010
multipass exec ulx-s-2204-l-d-010 -- sudo /home/ubuntu/ubuntu-dckr-demo-config-latest.sh
:: Docker images ophalen 
@ECHO Docker Pull Images binnen ulx-s-2204-l-d-010
multipass exec ulx-s-2204-l-d-010 -- /home/ubuntu/scripts/docker/pull-images/docker-pull-images.sh
::
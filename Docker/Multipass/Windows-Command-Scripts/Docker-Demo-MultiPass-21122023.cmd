:: 
:: Canonical MultiPASS Configuration Script
:: Version 1.01 
:: Date December 21 2023 
:: Author John Tutert
:: 
:: Installatie SysInternals Suite vanwege PSExec tool 
:: Multipass draait alles onder SYSTEM account 
:: Zie https://jon.sprig.gs/blog/post/1574
winget install --id 9P7KNL5RWT25 --accept-package-agreements --accept-source-agreements
:: 
:: Starten DOCKER VM met eigen gekozen naam cpu memory settings 
multipass launch docker --name ulx-s-2204-l-d-010 --cpus 2 --memory 8192M
::
multipass stop ulx-s-2204-l-d-010
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
psexec "c:\program files\oracle\virtualbox\vboxmanage" modifyvm "ulx-s-2204-l-d-010" --nic2 hostonly --hostonlyadapter2 "VirtualBox Host-Only Ethernet Adapter"
::
:: Starten VM
multipass stop ulx-s-2204-l-d-010
:: 
:: Netwerkkaart 2 op DHCP Instellen 
multipass exec ulx-s-2204-l-d-010 -- sudo netplan set ethernets.enp0s8.dhcp4=true
multipass exec ulx-s-2204-l-d-010 -- sudo netplan apply
:: Ubuntu Repository aanpassen naar NL 
multipass exec ulx-s-2204-l-d-010 -- sudo sed "s@archive.ubuntu.com@nl.archive.ubuntu.com@" -i /etc/apt/sources.list
:: Ubuntu Repository bijwerken naar laatste stand van zaken
multipass exec ulx-s-2204-l-d-010 -- sudo apt update
multipass exec ulx-s-2204-l-d-010 -- sudo snap install curl 
multipass exec ulx-s-2204-l-d-010 -- curl -s -o /home/ubuntu/ubuntu-dckr-demo-config-latest.sh https://raw.githubusercontent.com/jatutert/docker-demos/main/ubuntu-dckr-demo-config-latest.sh
multipass exec ulx-s-2204-l-d-010 -- sudo chmod +x /home/ubuntu/ubuntu-dckr-demo-config-latest.sh
:: Ubuntu update en Docker-CE installeren (inclusief Compose plugin) 
multipass exec ulx-s-2204-l-d-010 -- sudo /home/ubuntu/ubuntu-dckr-demo-config-latest.sh
:: Docker images ophalen 
multipass exec ulx-s-2204-l-d-010 -- /home/ubuntu/scripts/docker/pull-images/docker-pull-images.sh
::
:: multipass stop ulx-s-2204-l-d-010
:: PsExec64.exe -s "c:\program files\oracle\virtualbox\vboxmanage" modifyvm "ulx-s-2204-l-d-010" --nic2 hostonly --hostonlyadapter2 "VirtualBox Host-Only Ethernet Adapter"
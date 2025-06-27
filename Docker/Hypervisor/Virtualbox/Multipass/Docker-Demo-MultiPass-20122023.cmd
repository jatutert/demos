:: 
:: Canonical MultiPASS Configuration Script
:: Version 1.00 
:: Date December 20 2023 
:: Author John Tutert
::
multipass launch docker --name ulx-s-2204-l-d-010 --cpus 2 --memory 8192M
multipass exec ulx-s-2204-l-d-010 -- sudo sed "s@archive.ubuntu.com@nl.archive.ubuntu.com@" -i /etc/apt/sources.list
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
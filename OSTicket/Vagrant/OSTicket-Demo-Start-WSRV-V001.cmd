::
::
::	Introductie Infrastructuren
::	OSTicket
::	Demo
::
::	2024/2025
::
::	::::	Opschonen geheugen host		::::
@RAMMap.exe -Ew
@RAMMap.exe -Es
::
::	::::	Starten WSRV Guest			::::
vagrant up u24-lts-s-wsrv-001
::
::	::::	Configuratie WSRV Guest		::::
vagrant ssh u24-lts-s-wsrv-001 --command "curl -o /etc/netplan/01-netcfg.yaml https://raw.githubusercontent.com/jatutert/demos/main/OSTicket/Guest/Ubuntu/Netplan/Webserver/01-netcfg.yaml"
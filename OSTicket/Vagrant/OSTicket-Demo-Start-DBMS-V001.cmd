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
::	::::	Starten DBMS Guest			::::
vagrant up u24-lts-S-dbms-001
::
::	::::	Configuratie DBMS Guest	 	::::
vagrant ssh u24-lts-S-dbms-001 --command "curl -o /etc/netplan/01-netcfg.yaml https://raw.githubusercontent.com/jatutert/demos/main/OSTicket/Guest/Ubuntu/Netplan/Databaseserver/01-netcfg.yaml"

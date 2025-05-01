::
::	Start dit script in dezelfde map als 17763.737.amd64fre.rs5_release_svc_refresh.190906-2324_server_serverdatacentereval_en-us_1.vhd.7z
::
::	Script pakt 7-ZIP bestand uit en doet conversie van VHD naar VMDK. Hierna wordt VHD verwijderd 
::
:: 	Versie 001
::	30 mei 2024
::	John Tutert 
::
::	Windows Server 2019
::	DataCenter
::	Evaluation (180 dagen)
::
::	Uitpakken 7ZIP bestand met VHD
@c:\PROGRA~1\7-Zip\7z x -bd -y -o"%USERPROFILE%\Downloads" D:\Installatie-Catalogus\VirtualDisks\Virtual-Harddisk-VHD\Windows\Windows-Server-2019\Trial\2019-September-06\17763.737.amd64fre.rs5_release_svc_refresh.190906-2324_server_serverdatacentereval_en-us_1.vhd.7z
::
@VBoxManage.exe clonemedium disk --format=VMDK "%USERPROFILE%\Downloads\17763.737.amd64fre.rs5_release_svc_refresh.190906-2324_server_serverdatacentereval_en-us_1.vhd" %USERPROFILE%\Downloads\17763.737.amd64fre.rs5_release_svc_refresh.190906-2324_server_serverdatacentereval_en-us_1.VMDK
@del %USERPROFILE%\Downloads\17763.737.amd64fre.rs5_release_svc_refresh.190906-2324_server_serverdatacentereval_en-us_1.vhd
::
::
echo Let OP !
echo.
Echo In VMWare Workstation na het maken van de virtuele machine de volgende instelling aanpassen
Echo.
Echo OPTIONS
Echo Advanced (Default/Default)
Echo.
Echo Selecteer BIOS ipv UEFI 
Echo.
Echo Doe je dit niet, dan start de VM niet in VMWare Workstation ! 
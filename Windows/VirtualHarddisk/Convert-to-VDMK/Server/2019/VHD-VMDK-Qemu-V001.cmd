::
::	Download VHD
::  Conversie VHD naar VMDK
::	Qemu IMG Converter
:: 	Command Line 
::
:: 	Versie 18 juni 2024
::	John Tutert 
::
::	Version Control
::
::	V001	Eerste versie 
::	V002	nvt
::
::	Downloaden VHD bestand vanaf 
:: 	https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019
::
::
powershell Invoke-WebRequest -URI https://go.microsoft.com/fwlink/p/?linkid=2195334&clcid=0x409&culture=en-us&country=us -OutFile %userprofile%\Downloads\WS19-DC-Trial.VHD
::
::
::	wget2 -O %USERPROFILE%\Downloads\17763.737.amd64fre.rs5_release_svc_refresh.190906-2324_server_serverdatacentereval_en-us_1.vhd "https://go.microsoft.com/fwlink/p/?linkid=2195334&clcid=0x409&culture=en-us&country=us"
::	::
::	:: Hernoemen VHD ivm te lange bestandsnaam voor conversie StarWind V2V
::	::
::	Rename %USERPROFILE%\Downloads\17763.737.amd64fre.rs5_release_svc_refresh.190906-2324_server_serverdatacentereval_en-us_1.vhd WS19-DC-Trial.vhd
::	::
::
::
::	Conversie van VHD naar VMDK met behulp van Qemu IMG Converter 
::
::	p - progress bar
::	O - determine the format of the output file
::
C:\"Program Files"\qemu\qemu-img convert -p %userprofile%\Downloads\WS19-DC-Trial.VHD -O vmdk %userprofile%\Downloads\WS19-DC-Trial.vmdk
:: 

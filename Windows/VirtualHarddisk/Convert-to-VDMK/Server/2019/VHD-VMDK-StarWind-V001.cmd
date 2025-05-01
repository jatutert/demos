::
::	Download VHD
::  Conversie VHD naar VMDK
::	StarWind V2V converter
:: 	Command Line 
::
:: 	Versie 30 mei 2024
::	John Tutert 
::
::	Downloaden VHD bestand vanaf 
:: 	https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019
::
wget2 -O %USERPROFILE%\Downloads\17763.737.amd64fre.rs5_release_svc_refresh.190906-2324_server_serverdatacentereval_en-us_1.vhd "https://go.microsoft.com/fwlink/p/?linkid=2195334&clcid=0x409&culture=en-us&country=us"
::
:: Hernoemen VHD ivm te lange bestandsnaam voor conversie StarWind V2V
::
Rename %USERPROFILE%\Downloads\17763.737.amd64fre.rs5_release_svc_refresh.190906-2324_server_serverdatacentereval_en-us_1.vhd WS19-DC-Trial.vhd
::
::	Conversie van VHD naar VMDK met behulp van StarWind V2V Converter 
::
"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="%USERPROFILE%\Downloads\WS19-DC-Trial.vhd" out_file_name="%USERPROFILE%\Downloads\WS19-DC-Trial.vmdk" out_file_type=ft_vmdk_ws_growable
:: 

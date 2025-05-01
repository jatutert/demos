::
::	Download VHD
::  Conversie VHD naar VDI
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
::
::	Eventueel download vanaf 
::	https://www.microsoft.com/en-us/evalcenter/download-virtual-hardware-lab-kit
::	
::	22H2	https://go.microsoft.com/fwlink/p/?linkid=2196266&clcid=0x409&culture=en-us&country=us
::	21H2	https://go.microsoft.com/fwlink/p/?linkid=2195267&clcid=0x409&culture=en-us&country=us
::			https://go.microsoft.com/fwlink/p/?linkid=2195153&clcid=0x409&culture=en-us&country=us
::			https://go.microsoft.com/fwlink/p/?linkid=2195402&clcid=0x409&culture=en-us&country=us



:: Hernoemen VHD ivm te lange bestandsnaam voor conversie StarWind V2V
::
Rename %USERPROFILE%\Downloads\17763.737.amd64fre.rs5_release_svc_refresh.190906-2324_server_serverdatacentereval_en-us_1.vhd WS19-DC-Trial.vhd
::
::	Conversie van VHD naar VDI met behulp van StarWind V2V Converter 
::	https://www.starwindsoftware.com/v2v-help/CommandLineInterface.html
::
::
::	ft_vhd_growable - MS VHD growable;
::	ft_vhd_pre_allocated - MS VHD pre-allocated;
::	ft_vhdx_growable - MS VHDX growable;
::	ft_vhdx_pre_allocated - MS VHDX pre-allocated;
::	ft_vmdk_ws_growable - VMDK growable for VMware Workstation;
::	ft_vmdk_ws_pre_allocated - VMDK pre-allocated for VMware Workstation;
::	ft_vmdk_esx_growable - VMDK growable for VMware ESXi Server;
::	ft_vmdk_esx_pre_allocated - VMDK pre-allocated for VMware ESXi Server;
::	ft_vmdk_so -  VMDK stream-optimized;
::	ft_raw - RAW image;
::	ft_qcow2 - QCOW2 virtual disk;
::	ft_vdi_growable - VDI growable for Oracle VirtualBox;
::	ft_vdi_pre_allocated - VDI pre-allocated for Oracle VirtualBox.
::
::

"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="%USERPROFILE%\Downloads\WS19-DC-Trial.vhd" out_file_name="%USERPROFILE%\Downloads\WS19-DC-Trial.vdi" out_file_type=ft_vdi_growable
:: 

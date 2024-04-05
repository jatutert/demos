::
:: Windows 11
:: https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/
:: 
:: Windows Server
:: https://www.microsoft.com/en-us/evalcenter/download-windows-server-2012-r2
:: https://www.microsoft.com/en-us/evalcenter/download-windows-server-2016
:: https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019
:: https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022
::
:: Windows Server 2019
:: 
:: Downloaden VHD
curl %USERPROFILE%\Downloads\Windows-Server-2019.VHD https://go.microsoft.com/fwlink/p/?linkid=2195334&clcid=0x409&culture=en-us&country=us
:: 
:: Converteren VHD naar Virtualbox VDI
:: https://www.thewindowsclub.com/convert-hyper-v-vm-to-virtualbox-or-vice-versa
VBoxManage.exe clonemedium disk "%USERPROFILE%\Downloads\Windows-Server-2019.VHD" %USERPROFILE%\Downloads\Windows-Server-2019.VDI
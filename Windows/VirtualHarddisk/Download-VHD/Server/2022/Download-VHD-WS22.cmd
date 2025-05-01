::
::	Downloaden Windows Server 2022 DataCenter Edition 180 days trial
::	VHD 
::
::	31 mei 2024
::	John Tutert
::
::	10 GB VHD Downloaden 
::
powershell Invoke-WebRequest -URI https://go.microsoft.com/fwlink/p/?linkid=2195166&clcid=0x409&culture=en-us&country=us -OutFile %userprofile%\Downloads\WS22-DC-Trial.VHD
::
::	In Powershell " er omheen zetten 
::	Invoke-WebRequest -URI "https://go.microsoft.com/fwlink/p/?linkid=2195166&clcid=0x409&culture=en-us&country=us" -OutFile .\WS22-DC-Trial.VHD
::


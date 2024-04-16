:: Download Windows Server 2019
:: Virtual Harddisk (VHD)
:: Trail
::
:: 8 april 2024
::
:: Auteur: John Tutert
:: 
:: 
wget2 >nul 2>&1
if %errorlevel% neq 0 (
  :: WGET2 is niet geïnstalleerd, installeer het
  winget install --id GNU.Wget2 --accept-package-agreements --accept-source-agreements --force >nul 2>&1
) else (
  :: WGET2 is geïnstalleerd, werk het bij
  winget upgrade --id GNU.Wget2 --accept-package-agreements --accept-source-agreements >nul 2>&1
)
::
::
wget2 -O %USERPROFILE%\Downloads\WS19DC-Trial.VHD "https://go.microsoft.com/fwlink/p/?linkid=2195334&clcid=0x409&culture=en-us&country=us"
::
:: That's all folks ! 
:: 

#
#   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
#     TT    U    U    TT    SS      O    O  FF        TT
#     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
#     TT    U    U    TT        SS  O    O  FF        TT
#     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
#
#   Windows Server 2022 DataCenter ISO naar Virtual Harddisk VHD
#   PowerSHELL SCRIPT
#
#   For Personal and/or Education Use Only ! 
#
#
#   17 APRIL 2026
#
#
#   LET OP!
#   Dit script maakt gebruik van Autounattend_SXN-DC-01-Latest.xml
#
#
Clear-Host
#
Write-Host " "
Write-Host "   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT"
Write-Host "     TT    U    U    TT    SS      O    O  FF        TT"
Write-Host "     TT    U    U    TT    SSSSSS  O    O  FFFF      TT"
Write-Host "     TT    U    U    TT        SS  O    O  FF        TT"
Write-Host "     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT"
Write-Host " "
#
#   #####################
#   DECLARATIE VARIABELEN
#   #####################
#
#
Write-Host "Declaratie van parameters voor Script"
#
#
$TS_WIN_ISO_FOLDER      = 'C:\Users\jtu03\Nextcloud\Shared\ISO-Bestanden\Operating-Systems\Windows\10-11\10.22-Windows-Server-2022\Standard-DataCenter-Microsoft\'
$TS_WIN_ISO_FILE        = 'en-us_windows_server_2022_updated_march_2026_x64_dvd_3f772967.iso'
$TS_WIN_UNATTEND_FOLDER = 'D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\Guest\Windows\2022\AutoUnattend\GitHub-Ruzickap\SXN-DB-01\'
$TS_WIN_UNATTEND_FILE   = 'Autounattend_SXN-DB-01-Latest.xml'
#
#
#   #####################
#   PARAMETERS CONVERSIE CMDLET
#   #####################
#
#
Write-Host "Declaratie van parameters voor conversie"
#
$ConvertParams          =   @{
#
SourcePath              =   $TS_WIN_ISO_FOLDER + $TS_WIN_ISO_FILE
#
VHDPath                 =   'D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\SXN-DB-01\SXN-DB-01.VHD'
#
SizeBytes               =   90GB
VHDFormat               =   'VHD' 
DiskLayout              =   'UEFI'
UnattendPath            =   $TS_WIN_UNATTEND_FOLDER + $TS_WIN_UNATTEND_FILE
Edition                 =   'Windows Server 2022 Datacenter (Desktop Experience)' 
Passthru                =   $True
BCDinVHD                =   'VirtualMachine'
}
#
#
#   #####################
#   CONVERSIE ISO NAAR VHD
#   #####################
#
#
Write-Host "Conversie Windows Server 2022 DataCenter ISO naar VHD gestart ..."
Convert-WindowsImage @ConvertParams
#
#
#   #####################
#   THATS ALL FOLKS
#   #####################
#
#
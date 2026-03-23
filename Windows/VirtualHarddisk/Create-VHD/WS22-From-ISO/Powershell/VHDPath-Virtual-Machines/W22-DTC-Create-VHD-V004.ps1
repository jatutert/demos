#
#   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
#     TT    U    U    TT    SS      O    O  FF        TT
#     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
#     TT    U    U    TT        SS  O    O  FF        TT
#     TT    UUUUUU    TT    SSSSSS  OOOOOOO FF        TT
#
#   Windows Server 2022 DataCenter ISO naar Virtual Harddisk VHD
#   PowerSHELL SCRIPT
#
#   For Personal and/or Education Use Only ! 
#
#
#   19 maart 2026
#
#
#   LET OP!
#   Dit script maakt gebruik van Schneegans autounattend.xml
#
#
Clear-Host
#
#
#   #####################
#   DECLARATIE VARIABELEN
#   #####################
#
#
$TS_WIN_ISO_FOLDER      = 'D:\Installatie-Catalogus\InstallatieMedia\Besturingssystemen\Microsoft\Windows\10-10-11\10.22-Windows-Server-2022\Standard-DataCenter-Microsoft\'
$TS_WIN_ISO_FILE        = 'en-us_windows_server_2022_updated_march_2026_x64_dvd_3f772967.iso'
$TS_WIN_UNATTEND_FOLDER = 'D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\Guest\Windows\2022\AutoUnattend\GitHub-Ruzickap\'
$TS_WIN_UNATTEND_FILE   = 'Autounattend_V007.xml'
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
VHDPath                 =   'D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Server\W22-DTC-S-LAB-001.VHD'
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
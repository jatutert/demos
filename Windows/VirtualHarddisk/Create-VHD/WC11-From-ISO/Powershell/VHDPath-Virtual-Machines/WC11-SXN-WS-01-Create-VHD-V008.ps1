#
#   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
#     TT    U    U    TT    SS      O    O  FF        TT
#     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
#     TT    U    U    TT        SS  O    O  FF        TT
#     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
#
#   Windows 11 Education ISO naar Virtual Harddisk VHD
#   PowerSHELL SCRIPT
#
#   For Personal and/or Education Use Only ! 
#
#
#   28 APRIL 2026
#
#
#   LET OP!
#   Dit script maakt gebruik van Schneegans autounattend.xml
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
$TS_WIN_ISO_FOLDER      = 'C:\Users\jtu03\Nextcloud\Shared\ISO-Bestanden\Operating-Systems\Windows\10-11\10.22-Windows-11\Consumer-Editions-Microsoft\25H2\Retail-OEM\'
$TS_WIN_ISO_FILE        = 'en-us_windows_11_consumer_editions_version_25h2_updated_march_2026_x64_dvd_a1cf6c36.iso'
$TS_WIN_UNATTEND_FOLDER = 'D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\Guest\Windows\11\AutoUnattend\GitHub-Ruzickap\SXN-WS-01\'
$TS_WIN_UNATTEND_FILE   = 'Autounattend_SXN-WS-01-Latest.xml'
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
VHDPath                 =   'D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\SXN-WS-01\SXN-WS-01.VHD'
#
SizeBytes               =   90GB
VHDFormat               =   'VHD' 
DiskLayout              =   'UEFI'
UnattendPath            =   $TS_WIN_UNATTEND_FOLDER + $TS_WIN_UNATTEND_FILE
Edition                 =   'Windows 11 Education' 
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
Write-Host "Conversie Windows 11 Education ISO naar VHD gestart ..."
Convert-WindowsImage @ConvertParams
#
#
#   #####################
#   VMware Tools overzetten op nieuwe VHD
#   #####################
#
#
#   Mounten VHD als schijf
Mount-DiskImage -ImagePath 'D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\SXN-WS-01\SXN-WS-01.VHD'
#
#   #   Ophalen toegewezen schijfletter
#   $vhdschijfltr = (Get-DiskImage -ImagePath 'D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\SXN-WS-01\SXN-WS-01.VHD' | Get-Disk | Get-Partition | Get-Volume ).DriveLetter
#
#   Mounten VMware Tools ISO
Mount-DiskImage -ImagePath "C:\Program Files (x86)\VMware\VMware Workstation\windows.iso"
#
#   #   Ophalen toegewezen schijfletter
#   $vmtlschijfltr = (Get-DiskImage -ImagePath "C:\Program Files (x86)\VMware\VMware Workstation\windows.iso" | Get-Disk | Get-Partition | Get-Volume ).DriveLetter
#
mkdir G:\vmware-tools -Force
#
#   Alle bestanden van de ISO overzetten naar VHD
cmd.exe /c "xcopy e:\*.* g:\vmware-tools /e /h /r /y"
#
#   Dismounten VHD 
DisMount-DiskImage -ImagePath 'D:\Virtual-Machines\Oracle-VM-Virtualbox\Windows\Client\SXN-WS-01\SXN-WS-01.VHD'
#
#   Dismounten ISO
DisMount-DiskImage -ImagePath 'C:\Program Files (x86)\VMware\VMware Workstation\windows.iso'
#
#
#   #####################
#   THATS ALL FOLKS
#   #####################
#
#
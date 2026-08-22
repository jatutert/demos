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
#   21 Augustus 2026
#
#
#
#
Write-Host  "Powershell ISO 2 VHD Converter by TutSOFT Version 15"
#
#
#
#
#   #####################
#   Powershell Module
#   #####################
#
#   Zorgen dat Powershell module aanwezig is
Install-Module -Name Hyper-ConvertImage
#
#
#
#
#   #####################
#   DECLARATIE VARIABELEN
#   #####################
#
#
#
#
Write-Host  "ISO2VHD Stap 1 Declaratie van parameters voor Script"
#
#
#
#
$TS_WIN_ISO_FOLDER      = 'D:\Virtualization-Home\Installation-Media\OperatingSystems\Windows\10-11\10-22-Windows-11\Consumer-Editions-Microsoft\25H2\'
$TS_WIN_ISO_FILE        = 'en-us_windows_11_consumer_editions_version_25h2_updated_latest.iso'
#
$TS_WIN_UNATTEND_FOLDER = 'D:\OneDrive\OneDrive - Saxion\Bestanden\GitHub-JATUTERT\Demos\Windows\Guest\Windows\11\AutoUnattend\GitHub-Ruzickap\SXN-WS-01\'
$TS_WIN_UNATTEND_FILE   = 'Autounattend_SXN-WS-01-Latest.xml'
#
$TS_VHD_PATH            = 'D:\Virtualization-Home\Virtual-Machines\Microsoft-Hyper-V\Windows\Client\11\SXN-WS-01\SXN-WS-01.VHD'
#
#
Write-Host 'ISO-Bestand:' $TS_WIN_ISO_FOLDER $TS_WIN_ISO_FILE
Write-Host 'Unattend:' $TS_WIN_UNATTEND_FOLDER $TS_WIN_UNATTEND_FILE
Write-Host 'VHD:' $TS_VHD_PATH
#
#
#   #####################
#   PARAMETERS CONVERSIE CMDLET
#   #####################
#
#
#
#
Write-Host  "ISO2VHD Stap 2 Declaratie van parameters voor conversie"
#
#
#
#
$ConvertParams          =   @{
#
SourcePath              =   $TS_WIN_ISO_FOLDER + $TS_WIN_ISO_FILE
#
VHDPath                 =   $TS_VHD_PATH
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
#
#
Write-Host "ISO2VHD Stap 3 Maken SXN-WS-01 Virtual Harddisk op basis van ISO gestart ..."
Convert-WindowsImage @ConvertParams
#
#
#
#
#   #####################
#   VMware Tools overzetten op nieuwe VHD
#   #####################
#
#
#
#
Write-Host "ISO2VHD Stap 4 software overzetten op VHD"
# 
#   Mounten VHD als schijf
Mount-DiskImage -ImagePath "$TS_VHD_PATH"
#
#   #   Ophalen toegewezen schijfletter
#   $vhdschijfltr = (Get-DiskImage -ImagePath "$TS_VHD_PATH" | Get-Disk | Get-Partition | Get-Volume ).DriveLetter
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
#
#   ###################
#   SQL-Server Express
#   ###################
#
#
mkdir G:\SQL-Server-2022-Express -Force
#
cmd.exe /c "xcopy D:\SurfDrive-Home\Installation-Media\Application-Servers\DBMS\Microsoft\SQL-Server\SQL-Server-2022-Express\*.* g:\SQL-Server-2022-Express /e /h /r /y"
#
#   Dismounten VHD 
DisMount-DiskImage -ImagePath "$TS_VHD_PATH"
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
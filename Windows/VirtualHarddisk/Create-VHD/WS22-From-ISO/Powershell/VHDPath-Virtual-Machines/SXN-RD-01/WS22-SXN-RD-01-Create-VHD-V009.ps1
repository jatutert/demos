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
#   03 mei 2026
#
#
#   LET OP!
#   Dit script maakt gebruik van Schneegans autounattend.xml
#
#
#   Clear-Host
#
#   Write-Host " "
#   Write-Host "   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT"
#   Write-Host "     TT    U    U    TT    SS      O    O  FF        TT"
#   Write-Host "     TT    U    U    TT    SSSSSS  O    O  FFFF      TT"
#   Write-Host "     TT    U    U    TT        SS  O    O  FF        TT"
#   Write-Host "     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT"
#   Write-Host " "
#
#   #####################
#   DECLARATIE VARIABELEN
#   #####################
#
#
Write-Host  "TutSOFT" 
Write-Host  "Powershell ISO to VHD Converter"
#
Write-Host "ISOVHD Stap 1 Declaratie van parameters voor Script"
#
#
$TS_WIN_ISO_FOLDER      = 'C:\Users\jtu03\Nextcloud\Shared\ISO-Bestanden\Operating-Systems\Windows\10-11\10.22-Windows-Server-2022\Standard-DataCenter-Microsoft\'
$TS_WIN_ISO_FILE        = 'en-us_windows_server_2022_updated_latest.iso'
#
$TS_WIN_UNATTEND_FOLDER = 'D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\Guest\Windows\2022\AutoUnattend\GitHub-Ruzickap\SXN-RD-01\'
$TS_WIN_UNATTEND_FILE   = 'Autounattend_SXN-RD-01-Latest.xml'
#
$TS_VHD_PATH            = 'D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-RD-01\SXN-RD-01.VHD'
#
#
#   #####################
#   PARAMETERS CONVERSIE CMDLET
#   #####################
#
#
Write-Host "ISOVHD Stap 2 Declaratie van parameters voor conversie"
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
Write-Host "ISOVHD Stap 3 Conversie Windows Server 2022 DataCenter ISO naar VHD gestart ..."
Convert-WindowsImage @ConvertParams
#
#
#   #####################
#   VMware Tools overzetten op nieuwe VHD
#   #####################
#
#
Write-Host "ISOVHD Stap 4 VMWare Tools overzetten op VHD"
# 
#   Mounten VHD als schijf
Mount-DiskImage -ImagePath "$TS_VHD_PATH"
#
#   #   Ophalen toegewezen schijfletter
#   $vhdschijfltr = (Get-DiskImage -ImagePath 'D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-RD-01\SXN-RD-01.VHD' | Get-Disk | Get-Partition | Get-Volume ).DriveLetter
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
DisMount-DiskImage -ImagePath "$TS_VHD_PATH"
#
#   Dismounten ISO
DisMount-DiskImage -ImagePath 'C:\Program Files (x86)\VMware\VMware Workstation\windows.iso'
#
#
Write-Host  "ISOVHD VHD is aangemaakt"
#
#   #####################
#   THATS ALL FOLKS
#   #####################
#
#
#
#
#
#
#   TTTTTT  U    U  TTTTTT  SSSSSS  OOOOOO  FFFFFF  TTTTTT
#     TT    U    U    TT    SS      O    O  FF        TT
#     TT    U    U    TT    SSSSSS  O    O  FFFF      TT
#     TT    U    U    TT        SS  O    O  FF        TT
#     TT    UUUUUU    TT    SSSSSS  OOOOOO  FF        TT
#
#
#
#
#   Windows Server 2022 DataCenter ISO naar Virtual Harddisk VHD
#   PowerSHELL SCRIPT
#
#   SXN-DC-01 Edition of the script
#
#   For Personal and/or Education Use Only ! 
#
#   16 juli 2026
#
#
#
#
Write-Host  "Powershell ISO 2 VHD Converter by TutSOFT Version 10"
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
$TS_WIN_ISO_FOLDER      = 'C:\Users\jtu03\Nextcloud\Shared\ISO-Bestanden\Operating-Systems\Windows\10-11\10.22-Windows-Server-2022\Standard-DataCenter-Microsoft\'
$TS_WIN_ISO_FILE        = 'en-us_windows_server_2022_updated_latest.iso'
#
$TS_WIN_UNATTEND_FOLDER = 'D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-GitDesktop\Demos\Windows\Guest\Windows\2022\AutoUnattend\GitHub-Ruzickap\SXN-DC-01\'
$TS_WIN_UNATTEND_FILE   = 'Autounattend_SXN-DC-01-Latest.xml'
#
$TS_VHD_PATH            = 'D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-DC-01\SXN-DC-01.VHD'
#
#
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
Edition                 =   'Windows Server 2022 Datacenter (Desktop Experience)' 
Passthru                =   $True
BCDinVHD                =   'VirtualMachine'
}
#
#
#
#
#
#   #####################
#   CONVERSIE ISO NAAR VHD
#   #####################
#
#
#
#
Write-Host "ISO2VHD Stap 3 Maken SXN-DC-01 Virtual Harddisk op basis van ISO gestart ..."
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
Write-Host "ISO2VHD Stap 4 VMWare Tools overzetten op VHD"
# 
#   Mounten VHD als schijf
Mount-DiskImage -ImagePath "$TS_VHD_PATH"
#
#   #   Ophalen toegewezen schijfletter
#   $vhdschijfltr = (Get-DiskImage -ImagePath 'D:\Virtual-Machines\Microsoft-Hyper-V\Windows\Server\SXN-DC-01\SXN-DC-01.VHD' | Get-Disk | Get-Partition | Get-Volume ).DriveLetter
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
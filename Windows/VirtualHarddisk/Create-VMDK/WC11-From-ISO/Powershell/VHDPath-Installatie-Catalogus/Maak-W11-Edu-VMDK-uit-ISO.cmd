::
::	Create VMDK from ISO via VHD(X) using Powershell
::	Version: 1
::
::	Channel: ALPHA
::
::	Author: John Tutert
::
::	April 2025
::
::
:: 	Echo Hardware Productkey
::	wmic path softwarelicensingservice get OA3xOriginalProductKey
::
::
@echo off
@cls
::
::
::
:: 
::  Laat zien of de module Hyper-ConvertImage aanwezig is
::  @Powershell Get-Module -ListAvailable -Name Hyper-ConvertImage
::
::  Installeren Hyper-ConvertImage in Powershell
::  @powershell Install-Module -Name Hyper-ConvertImage -Repository PSGallery
::
::  Convert ISO to VHD using Powershell (gebruikt Hyper-ConvertImage)
::  Powershell script uit ISO naar VHD directory wordt gebruikt
::
::  [Stap 1] Aanmaken VHD bestand
@Powershell -file "D:\OneDrive\OneDrive - Saxion\Repository-Playground\Development\GitHub-JATUTERT-Repositories\demos\Windows\VirtualHarddisk\Create-VHD\WC11-From-ISO\Powershell\VHDPath-Installatie-Catalogus\PS-ConvertImage-WC11-Edu-V12.ps1"
::
::  [Stap 2] Converteren VHD naar VMDK (Gebruikt StarWind V2V Converter)
::  LET OP! Dit bestand komt in een ANDERE MAP dan VHD te staan
::  VHD verwijderen ??? na conversie om ruimte te besparen ???
"C:\Program Files\StarWind Software\StarWind V2V Converter\V2V_ConverterConsole.exe" convert in_file_name="D:\Installatie-Catalogus\VirtualDisks\Virtual-Harddisk-VHD\Windows\Windows-11\W11-Retail-EDU-24H2.VHD" out_file_name="D:\Installatie-Catalogus\VirtualDisks\Virtual-Machine-Disk-Format-VMDK\Windows\Windows 11\W11-Retail-EDU-24H2.VMDK" out_file_type=ft_vmdk_ws_growable
::
::  [Stap x] Aanmaken virtuele machine in VMware Workstation Pro
::  Hiervoor is script aanwezig onder hypervisor 

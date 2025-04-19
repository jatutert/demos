:: Echo Hardware Productkey
:: wmic path softwarelicensingservice get OA3xOriginalProductKey
::
@echo off
@cls
::
:: Laat zien of Hyper-ConvertImage aanwezig is
@Powershell Get-Module -ListAvailable -Name Hyper-ConvertImage
::
@Powershell -file .\Maak-W11-Edu-VHD-uit-ISO-V001.ps1
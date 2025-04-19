# Controleer of de module Hyper-ConvertImage aanwezig is
if (-not (Get-Module -ListAvailable -Name Hyper-ConvertImage)) {
    Write-Output "Module Hyper-ConvertImage is niet aanwezig. Installeren..."
    Install-Module -Name Hyper-ConvertImage -Scope CurrentUser -Force
    Write-Output "Module Hyper-ConvertImage is geïnstalleerd."
} else {
    Write-Output "Module Hyper-ConvertImage is al aanwezig. Geen actie nodig."
}
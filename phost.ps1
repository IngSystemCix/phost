# PHOST - CLI-first local hosting stack for Windows
# Version 0.1.0
# Author: Juan Romero Collazos

$PHOST_VERSION = "0.1.0"
$ROOT = Split-Path -Parent (Resolve-Path $MyInvocation.MyCommand.Path)

# -----------------------------
# Helpers
# -----------------------------
function Wait-CLI {
    Write-Host ""
    Read-Host "Press Enter to continue"
}

# -----------------------------
# Cargar librerías
# -----------------------------
. "$ROOT\lib\nginx.ps1"
. "$ROOT\lib\apache.ps1"
. "$ROOT\lib\mariadb.ps1"

# -----------------------------
# Banner
# -----------------------------
function Show-Banner {
    $BannerPath = Join-Path $ROOT "assets\banner.txt"

    if (Test-Path $BannerPath) {
        Write-Host (Get-Content $BannerPath -Raw) -ForegroundColor Cyan
    }
    else {
        Write-Host "PHOST" -ForegroundColor Cyan
    }

    Write-Host "PHOST - CLI-first local hosting stack for Windows" -ForegroundColor White
    Write-Host "------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "Author: Juan Romero Collazos" -ForegroundColor DarkGray
    Write-Host "------------------------------------------------" -ForegroundColor DarkGray
    Write-Host ""
}

function Show-Header {
    Clear-Host
    Show-Banner
    Write-Host "Version $PHOST_VERSION" -ForegroundColor DarkGray
    Write-Host ""
}

function Show-Menu {
    Write-Host "Select an option:" -ForegroundColor Yellow
    Write-Host "[1] Start services"
    Write-Host "[2] Stop services"
    Write-Host "[3] Status"
    Write-Host "[4] Run Doctor"
    Write-Host "[0] Exit"
    Write-Host ""
}

# -----------------------------
# Menu loop
# -----------------------------
function Invoke-Menu {
    while ($true) {
        Show-Header
        Show-Menu

        $choice = Read-Host "PHOST >"

        switch ($choice) {
            "1" { Invoke-Up }
            "2" { Invoke-Down }
            "3" { Invoke-Status }
            "4" { Invoke-Doctor }
            "0" {
                Write-Host "`nBye!" -ForegroundColor DarkGray
                return
            }
            default {
                Write-Host "Invalid option" -ForegroundColor Red
                Start-Sleep 1
            }
        }
    }
}

# -----------------------------
# Commands
# -----------------------------
function Invoke-Up {
    Write-Host "Select services to start:" -ForegroundColor Yellow
    Write-Host "[1] Nginx"
    Write-Host "[2] Apache"
    Write-Host "[3] MariaDB"
    Write-Host "[A] All"
    Write-Host ""

    $options = Read-Host "Enter options (ex: 1,3 or A)"
    Write-Host "`nStarting selected services..." -ForegroundColor Green

    if ($options -match "1|A") { Start-Nginx }
    if ($options -match "2|A") { Start-Apache }
    if ($options -match "3|A") { Start-MariaDB }

    Write-Host "`nAll selected services started" -ForegroundColor Green
    Wait-CLI
}

function Invoke-Down {
    Write-Host "Stopping all services..." -ForegroundColor Red
    Stop-Nginx
    Stop-Apache
    Stop-MariaDB
    Write-Host "`nAll services stopped" -ForegroundColor Red
    Wait-CLI
}

function Invoke-Status {
    Write-Host "Checking service status..." -ForegroundColor Cyan
    Get-NginxStatus
    Get-ApacheStatus
    Get-MariaDBStatus
    Wait-CLI
}

function Invoke-Doctor {
    Write-Host "Running system diagnostics..." -ForegroundColor Magenta
    Get-NginxStatus
    Get-ApacheStatus
    Get-MariaDBStatus
    Write-Host "Diagnostics complete" -ForegroundColor Green
    Wait-CLI
}

# -----------------------------
# Ejecutar
# -----------------------------
Invoke-Menu

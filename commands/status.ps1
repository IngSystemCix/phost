function Invoke-Status {

    Write-Host "Checking service status..." -ForegroundColor Cyan

    # Llamadas correctas a las funciones definidas en las librerías
    Get-NginxStatus
    Get-ApacheStatus
    Get-MariaDBStatus
    Get-PHPStatus

    Write-Host ""
    Pause
}

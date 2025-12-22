function Invoke-Down {

    Write-Host "Stopping all services..." -ForegroundColor Red

    Stop-Nginx
    Stop-Apache
    Stop-MariaDB
    Unload-PHP

    Write-Host ""
    Write-Host "All services stopped" -ForegroundColor Red
    Pause
}

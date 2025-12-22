function Invoke-Doctor {

    Write-Host "Running PHOST system check..." -ForegroundColor Magenta

    # Validar existencia de binarios
    if (-Not (Test-Path "bin/nginx/nginx.exe")) { Write-Host "Nginx missing!" -ForegroundColor Red }
    if (-Not (Test-Path "bin/apache/bin/httpd.exe")) { Write-Host "Apache missing!" -ForegroundColor Red }
    if (-Not (Test-Path "bin/mariadb/bin/mysqld.exe")) { Write-Host "MariaDB missing!" -ForegroundColor Red }
    if (-Not (Test-Path "bin/php/php.exe")) { Write-Host "PHP missing!" -ForegroundColor Red }

    # Comprobar puertos comunes (ejemplo básico)
    $tcp = Get-NetTCPConnection -State Listen
    if ($tcp.LocalPort -contains 80) { Write-Host "Port 80 in use" -ForegroundColor Yellow }
    if ($tcp.LocalPort -contains 8080) { Write-Host "Port 8080 in use" -ForegroundColor Yellow }
    if ($tcp.LocalPort -contains 3306) { Write-Host "Port 3306 in use" -ForegroundColor Yellow }

    Write-Host ""
    Write-Host "Doctor check completed" -ForegroundColor Magenta
    Pause
}

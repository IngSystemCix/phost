function Invoke-Up {

    Write-Host "Select services to start:" -ForegroundColor Yellow
    Write-Host "[1] Nginx"
    Write-Host "[2] Apache"
    Write-Host "[3] MariaDB"
    Write-Host "[A] All"
    Write-Host ""

    $userInput = Read-Host "Enter options (ex: 1,3 or A)"

    $services = @{
        nginx   = $false
        apache  = $false
        mariadb = $false
    }

    if ($userInput -match "A") {
        $services.Keys | ForEach-Object { $services[$_] = $true }
    } else {
        if ($userInput -match "1") { $services.nginx = $true }
        if ($userInput -match "2") { $services.apache = $true }
        if ($userInput -match "3") { $services.mariadb = $true }
    }

    Write-Host ""
    Write-Host "Starting selected services..." -ForegroundColor Green

    if ($services.nginx)   { Start-Nginx }
    if ($services.apache)  { Start-Apache }
    if ($services.mariadb) { Start-MariaDB }

    Write-Host ""
    Write-Host "All selected services started" -ForegroundColor Green
    Pause
}

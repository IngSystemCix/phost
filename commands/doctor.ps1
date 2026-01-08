function Invoke-Doctor {

    Write-Host "Running PHOST system check..." -ForegroundColor Magenta
    Write-Host "--------------------------------" -ForegroundColor DarkGray

    # =========================
    # BINARIOS
    # =========================
    Write-Host "Checking binaries..." -ForegroundColor Cyan

    $errors = 0

    if (-Not (Test-Path "bin/nginx/nginx.exe")) {
        Write-Host "✖ Nginx missing" -ForegroundColor Red
        $errors++
    } else {
        Write-Host "✔ Nginx OK" -ForegroundColor Green
    }

    if (-Not (Test-Path "bin/apache/bin/httpd.exe")) {
        Write-Host "✖ Apache missing" -ForegroundColor Red
        $errors++
    } else {
        Write-Host "✔ Apache OK" -ForegroundColor Green
    }

    if (-Not (Test-Path "bin/mariadb/bin/mysqld.exe")) {
        Write-Host "✖ MariaDB missing" -ForegroundColor Red
        $errors++
    } else {
        Write-Host "✔ MariaDB OK" -ForegroundColor Green
    }

    if (-Not (Test-Path "bin/php/php.exe")) {
        Write-Host "✖ PHP missing" -ForegroundColor Red
        $errors++
    } else {
        Write-Host "✔ PHP OK" -ForegroundColor Green
    }

    # =========================
    # PUERTOS
    # =========================
    Write-Host ""
    Write-Host "Checking ports..." -ForegroundColor Cyan

    $ports = Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue | Select-Object -ExpandProperty LocalPort

    foreach ($port in @(80, 8080, 3306)) {
        if ($ports -contains $port) {
            Write-Host "⚠ Port $port is in use" -ForegroundColor Yellow
        } else {
            Write-Host "✔ Port $port available" -ForegroundColor Green
        }
    }

    # =========================
    # VERSION / UPDATE CHECK
    # =========================
    Write-Host ""
    Write-Host "Checking updates..." -ForegroundColor Cyan

    try {
        $runtime = Get-Content "control/runtime.json" | ConvertFrom-Json
        $localVersion = $runtime.version

        $repo = "IngSystemCix/phost"
        $api  = "https://api.github.com/repos/$repo/releases/latest"

        $response = Invoke-RestMethod -Uri $api -Headers @{
            "User-Agent" = "phost"
        }

        $remoteVersion = $response.tag_name.TrimStart("v")

        if ($remoteVersion -ne $localVersion) {
            Write-Host "⚠ Update available: v$remoteVersion (installed: v$localVersion)" -ForegroundColor Yellow
            Write-Host "👉 Run: phost update" -ForegroundColor DarkYellow
        } else {
            Write-Host "✔ PHOST is up to date (v$localVersion)" -ForegroundColor Green
        }
    } catch {
        Write-Host "⚠ Unable to check updates" -ForegroundColor DarkYellow
    }

    # =========================
    # RESULTADO FINAL
    # =========================
    Write-Host ""
    if ($errors -gt 0) {
        Write-Host "Doctor completed with issues" -ForegroundColor Red
    } else {
        Write-Host "Doctor completed successfully" -ForegroundColor Magenta
    }

    Pause
}
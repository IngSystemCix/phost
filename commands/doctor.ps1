function Invoke-Doctor {

    Clear-Host
    Write-Host "Running PHOST system diagnostics..." -ForegroundColor Magenta
    Write-Host "-----------------------------------" -ForegroundColor DarkGray

    $ROOT = Split-Path -Parent $MyInvocation.MyCommand.Definition
    $errors = 0

    # =========================
    # BINARIOS
    # =========================
    Write-Host ""
    Write-Host "Checking binaries..." -ForegroundColor Cyan

    $binaries = @{
        "Nginx"    = "bin\nginx\nginx.exe"
        "Apache"  = "bin\apache\bin\httpd.exe"
        "MariaDB" = "bin\mariadb\bin\mysqld.exe"
        "PHP"     = "bin\php\php.exe"
    }

    foreach ($bin in $binaries.GetEnumerator()) {
        $path = Join-Path $ROOT $bin.Value
        if (-not (Test-Path $path)) {
            Write-Host "✖ $($bin.Key) missing" -ForegroundColor Red
            $errors++
        } else {
            Write-Host "✔ $($bin.Key) OK" -ForegroundColor Green
        }
    }

    # =========================
    # PUERTOS
    # =========================
    Write-Host ""
    Write-Host "Checking ports..." -ForegroundColor Cyan

    $listeningPorts = Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
                      Select-Object -ExpandProperty LocalPort

    foreach ($port in @(80, 8080, 3306)) {
        if ($listeningPorts -contains $port) {
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
        $runtimePath = Join-Path $ROOT "control\runtime.json"

        if (-not (Test-Path $runtimePath)) {
            throw "runtime.json not found"
        }

        $runtime = Get-Content $runtimePath -Raw | ConvertFrom-Json
        $localVersion = $runtime.version.Trim()

        $repo = "IngSystemCix/phost"
        $api  = "https://api.github.com/repos/$repo/releases/latest"

        $response = Invoke-RestMethod -Uri $api -Headers @{
            "User-Agent" = "phost-cli"
        }

        if (-not $response.tag_name) {
            throw "No release information available"
        }

        $remoteVersion = $response.tag_name.Trim().TrimStart("v")

        if ($remoteVersion -ne $localVersion) {
            Write-Host "⚠ Update available" -ForegroundColor Yellow
            Write-Host "   Installed : v$localVersion" -ForegroundColor DarkYellow
            Write-Host "   Available : v$remoteVersion" -ForegroundColor DarkYellow
            Write-Host "👉 Run: phost update" -ForegroundColor Cyan
        } else {
            Write-Host "✔ PHOST is up to date (v$localVersion)" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "⚠ Unable to check updates" -ForegroundColor DarkYellow
        Write-Host "   $($_.Exception.Message)" -ForegroundColor DarkGray
    }

    # =========================
    # RESULTADO FINAL
    # =========================
    Write-Host ""
    if ($errors -gt 0) {
        Write-Host "Doctor completed with issues ($errors found)" -ForegroundColor Red
    } else {
        Write-Host "Doctor completed successfully" -ForegroundColor Magenta
    }

    Write-Host ""
    Pause
}

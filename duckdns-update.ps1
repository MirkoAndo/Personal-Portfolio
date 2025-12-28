<#
Aggiorna l'IP pubblico su DuckDNS per mirkoportfolio.duckdns.org.
Richiede: PowerShell, accesso internet.
#>

$domain = "mirkoportfolio"
$token = "fe66cd16-4413-41b3-8548-4bcad49de448"
$duckUrl = "https://www.duckdns.org/update?domains=$domain&token=$token&ip="
$logDir = Join-Path $PSScriptRoot "logs"
$logFile = Join-Path $logDir "duckdns.log"

if (-not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}

try {
    $response = Invoke-WebRequest -Uri $duckUrl -UseBasicParsing -TimeoutSec 10
    $timestamp = (Get-Date).ToString("s")
    $status = $response.Content.Trim()
    "$timestamp`t$status" | Out-File -FilePath $logFile -Append -Encoding utf8
    Write-Output "DuckDNS update: $status"
} catch {
    $timestamp = (Get-Date).ToString("s")
    "$timestamp`tERROR`t$($_.Exception.Message)" | Out-File -FilePath $logFile -Append -Encoding utf8
    Write-Error "DuckDNS update failed: $($_.Exception.Message)"
    exit 1
}

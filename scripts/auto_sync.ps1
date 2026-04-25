# Auto-sync E:/AgentOS/exports/ -> cad-cleanup-knowledge repo
# Triggered by Windows Task Scheduler every 2 minutes
# Routing rules:
#   *.json                              -> data/
#   START_HERE / MASTER_STATE / README / HANDOFF*  -> root
#   user_verdicts_* / *_verdicts.md     -> verdicts/  (with user_verdicts_ prefix stripped)
#   all other *.md                      -> archive/

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

# Ensure subdirs exist
foreach ($sub in @("data","verdicts","archive","scripts")) {
    $p = Join-Path $repoRoot $sub
    if (-not (Test-Path $p)) { New-Item -ItemType Directory -Path $p -Force | Out-Null }
}

# Files that ALWAYS stay in root (these belong to repo meta, not exports)
$rootProtected = @("README.md", ".gitignore")

# Files that get copied to root (high-priority chat-Claude docs)
$rootDocs = @("START_HERE.md", "MASTER_STATE.md")

function Get-Target-Path {
    param([string]$filename)
    $name = [System.IO.Path]::GetFileName($filename)
    $ext  = [System.IO.Path]::GetExtension($name).ToLower()

    if ($ext -eq ".json") {
        return (Join-Path $repoRoot ("data\" + $name))
    }
    if ($ext -ne ".md") {
        return $null  # ignore other types
    }

    # MD routing
    if ($rootDocs -contains $name) {
        return (Join-Path $repoRoot $name)
    }
    if ($name -like "HANDOFF*") {
        return (Join-Path $repoRoot $name)
    }

    # Verdicts: user_verdicts_<x>.md -> verdicts/<x>.md (strip prefix for cleaner naming)
    if ($name -like "user_verdicts_*") {
        $clean = $name -replace "^user_verdicts_", ""
        return (Join-Path $repoRoot ("verdicts\" + $clean))
    }
    if ($name -like "*_verdicts.md") {
        return (Join-Path $repoRoot ("verdicts\" + $name))
    }

    # Default: archive
    return (Join-Path $repoRoot ("archive\" + $name))
}

$copied = 0

$allFiles = Get-ChildItem -Path $src -File | Where-Object {
    $_.Extension -eq ".md" -or $_.Extension -eq ".json"
}

foreach ($f in $allFiles) {
    if ($rootProtected -contains $f.Name) { continue }

    $dest = Get-Target-Path $f.FullName
    if (-not $dest) { continue }

    $needsCopy = $true
    if (Test-Path $dest) {
        $srcHash  = (Get-FileHash $f.FullName -Algorithm MD5).Hash
        $destHash = (Get-FileHash $dest -Algorithm MD5).Hash
        if ($srcHash -eq $destHash) { $needsCopy = $false }
    }
    if ($needsCopy) {
        $destDir = Split-Path $dest
        if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
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

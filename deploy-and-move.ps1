# Nutriva Website — Deploy & Move Script
# Double-click this file OR run from PowerShell:
#   Right-click -> "Run with PowerShell"

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Nutriva Website — Deploy & Reorganise" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Auto-detect the script's own folder (works regardless of where you run it from)
$scriptDir = $PSScriptRoot
if (-not $scriptDir) {
    # Fallback if run via double-click
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
}
Write-Host "  Source folder: $scriptDir" -ForegroundColor DarkGray
Write-Host ""

# ── STEP 1: Push to GitHub (triggers Vercel auto-deploy) ──────────────────────
Write-Host "Step 1/2: Pushing fixes to GitHub..." -ForegroundColor Yellow

Set-Location $scriptDir

# Clear any stale git lock
$lock = Join-Path $scriptDir ".git\index.lock"
if (Test-Path $lock) {
    Remove-Item $lock -Force
    Write-Host "  Cleared stale git lock" -ForegroundColor DarkGray
}

git push origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "  [!] Git push failed. Make sure you're logged in to GitHub." -ForegroundColor Red
    Write-Host "  Continuing to folder move step..." -ForegroundColor DarkGray
} else {
    Write-Host "  Done! Vercel will deploy in ~30 seconds." -ForegroundColor Green
}
Write-Host ""

# ── STEP 2: Move nutriva-website to Documents\Website ────────────────────────
Write-Host "Step 2/2: Moving website folder to Documents\Website..." -ForegroundColor Yellow

$docsPath    = [Environment]::GetFolderPath("MyDocuments")
$destination = Join-Path $docsPath "Website"
$finalDest   = Join-Path $destination "nutriva-website"
$source      = $scriptDir   # This IS the nutriva-website folder

Write-Host "  Moving to: $finalDest" -ForegroundColor DarkGray

# Create destination if it doesn't exist
if (-Not (Test-Path $destination)) {
    New-Item -ItemType Directory -Path $destination | Out-Null
    Write-Host "  Created folder: $destination" -ForegroundColor DarkGray
}

if (Test-Path $finalDest) {
    Write-Host "  [!] Folder already exists at destination: $finalDest" -ForegroundColor Yellow
    Write-Host "  Skipping move (already done)." -ForegroundColor DarkGray
} else {
    # Move the folder up one level (out of Projects, into Documents\Website)
    Set-Location (Split-Path -Parent $source)
    Move-Item -Path $source -Destination $finalDest
    Write-Host "  Moved successfully!" -ForegroundColor Green
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  All done!" -ForegroundColor Green
Write-Host ""
Write-Host "  Website live at:  https://nutrivaai.com" -ForegroundColor White
Write-Host "  Local files now:  $finalDest" -ForegroundColor White
Write-Host ""
Write-Host "  To keep using Cowork with this folder," -ForegroundColor DarkGray
Write-Host "  select the new location next time you open the app:" -ForegroundColor DarkGray
Write-Host "  $finalDest" -ForegroundColor DarkGray
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

Read-Host "Press Enter to close"

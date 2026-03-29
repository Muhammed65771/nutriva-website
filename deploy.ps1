# Nutriva Website — One-Click Deploy Script
# Run this from PowerShell in the nutriva-website folder:
#   cd "C:\Users\Muhammed\Documents\Projects\nutriva-website"
#   .\deploy.ps1

Write-Host "🚀 Nutriva Website Deploy" -ForegroundColor Cyan

# Remove stale git lock if present
$lock = ".git\index.lock"
if (Test-Path $lock) {
    Remove-Item $lock -Force
    Write-Host "  ✓ Cleared stale git lock" -ForegroundColor Green
}

# Stage all updated files
git add index.html vercel.json food-bowl.png favicon.png terms.html
Write-Host "  ✓ Files staged" -ForegroundColor Green

# Commit
git commit -m "Redesign: GSAP animations, 3D phone, aurora canvas, security headers"
Write-Host "  ✓ Committed" -ForegroundColor Green

# Push to GitHub (Vercel auto-deploys from main branch)
git push origin main
Write-Host "  ✓ Pushed to GitHub — Vercel is now building..." -ForegroundColor Green

Write-Host ""
Write-Host "Done! Your site will be live at https://nutrivaai.com in ~30 seconds." -ForegroundColor Cyan

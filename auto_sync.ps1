param([string] = "Auto update clinic app features")
git add .
git commit -m ""
git push origin main
Write-Host "Changes successfully pushed to GitHub!" -ForegroundColor Green

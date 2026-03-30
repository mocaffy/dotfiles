# User login startup script for komorebic and yasb

# Start Komorebi
Write-Host "Starting Komorebi..." -ForegroundColor Green
Start-Process -FilePath "komorebic" -ArgumentList "start --whkd" -WindowStyle Hidden

# Start yasb
Write-Host "Starting yasb..." -ForegroundColor Green
Start-Process -FilePath "yasb" -WindowStyle Hidden

Write-Host "User startup completed." -ForegroundColor Cyan

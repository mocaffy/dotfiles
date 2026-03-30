@echo off
start "" /min powershell -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -File "%~dp0sunshine-subinstances.ps1"

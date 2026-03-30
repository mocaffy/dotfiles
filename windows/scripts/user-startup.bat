@echo off
start "" /min powershell -ExecutionPolicy Bypass -NoProfile -WindowStyle Hidden -File "%~dp0user-startup.ps1"

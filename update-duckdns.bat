@echo off
setlocal enableextensions

REM Aggiorna l'IP su DuckDNS per mirkoportfolio.duckdns.org
REM Uso: update-duckdns.bat

powershell -ExecutionPolicy Bypass -File "%~dp0duckdns-update.ps1"

endlocal

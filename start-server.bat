@echo off
setlocal enableextensions

:: Uso: start-server.bat [PORT]
set PORT=%1
if "%PORT%"=="" set PORT=80

if exist server.pid (
  echo Avviso: server.pid esiste gia. Il server potrebbe essere in esecuzione.
)

REM Avvia in una nuova finestra cmd per non bloccare il terminale corrente.
start "portfolio-server" cmd /c "set PORT=%PORT% && py -3 server.py"

echo Server avviato (porta %PORT%).
endlocal

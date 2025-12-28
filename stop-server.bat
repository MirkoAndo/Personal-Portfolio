@echo off
setlocal enableextensions

if not exist server.pid (
  echo Nessun file server.pid trovato. Il server sembra non essere in esecuzione.
  exit /b 0
)

set /p PID=<server.pid
if "%PID%"=="" (
  echo Il file server.pid e' vuoto.
  exit /b 1
)

taskkill /PID %PID% /T /F >nul 2>&1
if %ERRORLEVEL%==0 (
  echo Server (PID %PID%) terminato.
  del server.pid >nul 2>&1
) else (
  echo Impossibile terminare il processo con PID %PID%.
)

endlocal

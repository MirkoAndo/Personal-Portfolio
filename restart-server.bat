@echo off
setlocal enableextensions

call stop-server.bat
call start-server.bat %1

endlocal

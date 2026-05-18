@echo off
echo.
echo ==============================================================
echo   DevSecOps Platform Engineer — Installation Windows
echo ==============================================================
echo.
powershell -ExecutionPolicy Bypass -File "%~dp0install.ps1"
if %ERRORLEVEL% NEQ 0 ( echo. & echo [ERREUR] Essayez: clic droit install.ps1 ^> Executer avec PowerShell & pause )

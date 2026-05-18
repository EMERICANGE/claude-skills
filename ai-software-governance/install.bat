@echo off
:: ============================================================
:: Lanceur d'installation — AI Software Governance Plugin
:: Double-cliquez sur ce fichier pour installer le plugin
:: ============================================================

echo.
echo ==============================================================
echo   AI Software Governance Plugin — Installation Windows
echo ==============================================================
echo.

:: Lancer le script PowerShell
powershell -ExecutionPolicy Bypass -File "%~dp0install.ps1"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [ERREUR] L'installation a echoue.
    echo Essayez de lancer PowerShell en administrateur :
    echo   clic droit sur install.ps1 ^> Executer avec PowerShell
    echo.
    pause
)

@echo off
:: ============================================================
:: Lanceur d'installation — Interactive Functional Tester Plugin
:: Double-cliquez sur ce fichier pour installer le plugin
:: ============================================================

echo.
echo ==============================================================
echo   Interactive Functional Tester Plugin — Installation Windows
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

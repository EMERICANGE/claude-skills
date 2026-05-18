# ============================================================
# Script d'installation — Interactive Functional Tester Plugin
# Pour Claude Code (CLI / Desktop / IDE) — Windows PowerShell
# ============================================================

$ErrorActionPreference = "Stop"

$PluginName = "interactive-functional-tester"
$ClaudeDir = "$env:USERPROFILE\.claude"
$PluginDir = "$ClaudeDir\plugins\$PluginName"
$PluginsJson = "$ClaudeDir\plugins\installed_plugins.json"
$SettingsJson = "$ClaudeDir\settings.json"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host ""
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host "  Installation : Interactive Functional Tester v1.0.0" -ForegroundColor Cyan
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host ""

# Verifier que Claude Code est configure
if (-not (Test-Path $ClaudeDir)) {
    Write-Host "[ERREUR] Repertoire $ClaudeDir introuvable." -ForegroundColor Red
    Write-Host "         Lancez Claude Code au moins une fois avant d'installer ce plugin."
    exit 1
}

# Verifier Docker
$dockerInstalled = Get-Command docker -ErrorAction SilentlyContinue
if (-not $dockerInstalled) {
    Write-Host "[AVERTISSEMENT] Docker n'est pas installe ou pas dans le PATH." -ForegroundColor Yellow
    Write-Host "                Ce plugin necessite Docker pour fonctionner."
    Write-Host "                L'installation continue mais le plugin ne marchera pas sans Docker."
    Write-Host ""
}

# 1. Copier les fichiers du plugin
Write-Host "[1/4] Copie des fichiers du plugin..." -ForegroundColor Yellow

if (Test-Path $PluginDir) {
    Write-Host "       Le plugin existe deja. Mise a jour..."
    Remove-Item -Recurse -Force $PluginDir
}

New-Item -ItemType Directory -Path "$PluginDir\skills\$PluginName" -Force | Out-Null
Copy-Item "$ScriptDir\package.json" -Destination "$PluginDir\" -Force
Copy-Item "$ScriptDir\skills\$PluginName\SKILL.md" -Destination "$PluginDir\skills\$PluginName\" -Force
if (Test-Path "$ScriptDir\README.md") {
    Copy-Item "$ScriptDir\README.md" -Destination "$PluginDir\" -Force
}

Write-Host "       -> $PluginDir" -ForegroundColor Green
Write-Host ""

# 2. Enregistrer dans installed_plugins.json
Write-Host "[2/4] Enregistrement dans installed_plugins.json..." -ForegroundColor Yellow

$PluginsDir = "$ClaudeDir\plugins"
if (-not (Test-Path $PluginsDir)) {
    New-Item -ItemType Directory -Path $PluginsDir -Force | Out-Null
}

if (-not (Test-Path $PluginsJson)) {
    @'
{
  "version": 2,
  "plugins": {}
}
'@ | Set-Content -Path $PluginsJson -Encoding UTF8
}

$installDate = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.000Z")
$pluginsData = Get-Content $PluginsJson -Raw | ConvertFrom-Json

$entry = @(
    @{
        scope = "user"
        installPath = $PluginDir.Replace("\", "/")
        version = "1.0.0"
        installedAt = $installDate
        lastUpdated = $installDate
    }
)

if (-not $pluginsData.plugins) {
    $pluginsData | Add-Member -NotePropertyName "plugins" -NotePropertyValue @{} -Force
}

$pluginsData.plugins | Add-Member -NotePropertyName "interactive-functional-tester@local" -NotePropertyValue $entry -Force
$pluginsData | ConvertTo-Json -Depth 10 | Set-Content -Path $PluginsJson -Encoding UTF8

Write-Host "       -> OK" -ForegroundColor Green
Write-Host ""

# 3. Activer dans settings.json
Write-Host "[3/4] Activation dans settings.json..." -ForegroundColor Yellow

if (-not (Test-Path $SettingsJson)) {
    @'
{
  "enabledPlugins": {}
}
'@ | Set-Content -Path $SettingsJson -Encoding UTF8
}

$settingsData = Get-Content $SettingsJson -Raw | ConvertFrom-Json

if (-not $settingsData.enabledPlugins) {
    $settingsData | Add-Member -NotePropertyName "enabledPlugins" -NotePropertyValue @{} -Force
}

$settingsData.enabledPlugins | Add-Member -NotePropertyName "interactive-functional-tester@local" -NotePropertyValue $true -Force
$settingsData | ConvertTo-Json -Depth 10 | Set-Content -Path $SettingsJson -Encoding UTF8

Write-Host "       -> OK" -ForegroundColor Green
Write-Host ""

# 4. Verification
Write-Host "[4/4] Verification de l'installation..." -ForegroundColor Yellow

$skillExists = Test-Path "$PluginDir\skills\$PluginName\SKILL.md"
$registeredOk = (Get-Content $PluginsJson -Raw | ConvertFrom-Json).plugins."interactive-functional-tester@local" -ne $null
$enabledOk = (Get-Content $SettingsJson -Raw | ConvertFrom-Json).enabledPlugins."interactive-functional-tester@local" -eq $true

if ($skillExists -and $registeredOk -and $enabledOk) {
    Write-Host "       -> Tout est OK" -ForegroundColor Green
} else {
    Write-Host "[ERREUR] L'installation a echoue. Verifiez les fichiers manuellement." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host "  INSTALLATION REUSSIE" -ForegroundColor Cyan
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Prochaines etapes :" -ForegroundColor White
Write-Host "    1. Redemarrez Claude Code"
Write-Host "    2. Ouvrez un projet avec un cahier de tests"
Write-Host "    3. Tapez : /start-tests"
Write-Host ""
Write-Host "  Prerequis runtime :" -ForegroundColor White
Write-Host "    - Docker Desktop installe et demarre"
Write-Host "    - Un fichier de tests dans le projet (TESTS.md, etc.)"
Write-Host ""

Read-Host "Appuyez sur Entree pour fermer"

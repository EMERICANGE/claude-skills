$ErrorActionPreference = "Stop"
$PluginName = "devsecops-platform"
$ClaudeDir = "$env:USERPROFILE\.claude"
$PluginDir = "$ClaudeDir\plugins\$PluginName"
$PluginsJson = "$ClaudeDir\plugins\installed_plugins.json"
$SettingsJson = "$ClaudeDir\settings.json"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host ""
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host "  Installation : DevSecOps Platform Engineer v1.0.0" -ForegroundColor Cyan
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $ClaudeDir)) {
    Write-Host "[ERREUR] $ClaudeDir introuvable. Lancez Claude Code une premiere fois." -ForegroundColor Red
    exit 1
}

Write-Host "[1/4] Copie des fichiers..." -ForegroundColor Yellow
if (Test-Path $PluginDir) { Remove-Item -Recurse -Force $PluginDir }
New-Item -ItemType Directory -Path "$PluginDir\skills\$PluginName" -Force | Out-Null
Copy-Item "$ScriptDir\package.json" -Destination "$PluginDir\" -Force
Copy-Item "$ScriptDir\skills\$PluginName\SKILL.md" -Destination "$PluginDir\skills\$PluginName\" -Force
if (Test-Path "$ScriptDir\README.md") { Copy-Item "$ScriptDir\README.md" -Destination "$PluginDir\" -Force }
Write-Host "       -> $PluginDir" -ForegroundColor Green
Write-Host ""

Write-Host "[2/4] Enregistrement dans installed_plugins.json..." -ForegroundColor Yellow
if (-not (Test-Path "$ClaudeDir\plugins")) { New-Item -ItemType Directory -Path "$ClaudeDir\plugins" -Force | Out-Null }
if (-not (Test-Path $PluginsJson)) { '{"version": 2, "plugins": {}}' | Set-Content -Path $PluginsJson -Encoding UTF8 }
$installDate = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.000Z")
$pluginsData = Get-Content $PluginsJson -Raw | ConvertFrom-Json
$entry = @(@{ scope = "user"; installPath = $PluginDir.Replace("\", "/"); version = "1.0.0"; installedAt = $installDate; lastUpdated = $installDate })
if (-not $pluginsData.plugins) { $pluginsData | Add-Member -NotePropertyName "plugins" -NotePropertyValue @{} -Force }
$pluginsData.plugins | Add-Member -NotePropertyName "$PluginName@local" -NotePropertyValue $entry -Force
$pluginsData | ConvertTo-Json -Depth 10 | Set-Content -Path $PluginsJson -Encoding UTF8
Write-Host "       -> OK" -ForegroundColor Green
Write-Host ""

Write-Host "[3/4] Activation dans settings.json..." -ForegroundColor Yellow
if (-not (Test-Path $SettingsJson)) { '{"enabledPlugins": {}}' | Set-Content -Path $SettingsJson -Encoding UTF8 }
$settingsData = Get-Content $SettingsJson -Raw | ConvertFrom-Json
if (-not $settingsData.enabledPlugins) { $settingsData | Add-Member -NotePropertyName "enabledPlugins" -NotePropertyValue @{} -Force }
$settingsData.enabledPlugins | Add-Member -NotePropertyName "$PluginName@local" -NotePropertyValue $true -Force
$settingsData | ConvertTo-Json -Depth 10 | Set-Content -Path $SettingsJson -Encoding UTF8
Write-Host "       -> OK" -ForegroundColor Green
Write-Host ""

Write-Host "[4/4] Verification..." -ForegroundColor Yellow
if (Test-Path "$PluginDir\skills\$PluginName\SKILL.md") {
    Write-Host "       -> Tout est OK" -ForegroundColor Green
} else {
    Write-Host "[ERREUR] Installation echouee." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host "  INSTALLATION REUSSIE" -ForegroundColor Cyan
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Redemarrez Claude Code, puis tapez : /devops-deploy" -ForegroundColor White
Write-Host ""
Read-Host "Appuyez sur Entree pour fermer"

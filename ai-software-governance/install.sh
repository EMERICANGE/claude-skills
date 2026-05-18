#!/bin/bash
# ============================================================
# Script d'installation — AI Software Governance Plugin
# Pour Claude Code (CLI / Desktop / IDE)
# ============================================================

set -e

PLUGIN_NAME="ai-software-governance"
PLUGIN_DIR="$HOME/.claude/plugins/$PLUGIN_NAME"
PLUGINS_JSON="$HOME/.claude/plugins/installed_plugins.json"
SETTINGS_JSON="$HOME/.claude/settings.json"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "══════════════════════════════════════════════════════════"
echo "  Installation : AI Software Governance Plugin v1.0.0"
echo "══════════════════════════════════════════════════════════"
echo ""

# Vérifier que jq est disponible
if ! command -v jq &> /dev/null; then
  echo "[ERREUR] 'jq' est requis mais non installé."
  echo ""
  echo "  Installez-le :"
  echo "    Ubuntu/Debian : sudo apt install jq"
  echo "    Arch Linux    : sudo pacman -S jq"
  echo "    macOS         : brew install jq"
  echo "    Fedora        : sudo dnf install jq"
  echo ""
  exit 1
fi

# Vérifier que Claude Code est configuré
if [ ! -d "$HOME/.claude" ]; then
  echo "[ERREUR] Répertoire ~/.claude introuvable."
  echo "         Lancez Claude Code au moins une fois avant d'installer ce plugin."
  exit 1
fi

# 1. Copier les fichiers du plugin
echo "[1/4] Copie des fichiers du plugin..."

if [ -d "$PLUGIN_DIR" ]; then
  echo "       Le plugin existe déjà. Mise à jour..."
  rm -rf "$PLUGIN_DIR"
fi

mkdir -p "$PLUGIN_DIR/skills/$PLUGIN_NAME"
cp "$SCRIPT_DIR/package.json" "$PLUGIN_DIR/"
cp "$SCRIPT_DIR/skills/$PLUGIN_NAME/SKILL.md" "$PLUGIN_DIR/skills/$PLUGIN_NAME/"
cp "$SCRIPT_DIR/README.md" "$PLUGIN_DIR/" 2>/dev/null || true

echo "       -> $PLUGIN_DIR"
echo ""

# 2. Enregistrer dans installed_plugins.json
echo "[2/4] Enregistrement dans installed_plugins.json..."

mkdir -p "$HOME/.claude/plugins"

if [ ! -f "$PLUGINS_JSON" ]; then
  echo '{"version": 2, "plugins": {}}' > "$PLUGINS_JSON"
fi

INSTALL_DATE=$(date -u +"%Y-%m-%dT%H:%M:%S.000Z")
tmp=$(mktemp)
jq --arg path "$PLUGIN_DIR" --arg date "$INSTALL_DATE" \
  '.plugins["ai-software-governance@local"] = [{
    "scope": "user",
    "installPath": $path,
    "version": "1.0.0",
    "installedAt": $date,
    "lastUpdated": $date
  }]' "$PLUGINS_JSON" > "$tmp" && mv "$tmp" "$PLUGINS_JSON"

echo "       -> OK"
echo ""

# 3. Activer dans settings.json
echo "[3/4] Activation dans settings.json..."

if [ ! -f "$SETTINGS_JSON" ]; then
  echo '{"enabledPlugins": {}}' > "$SETTINGS_JSON"
fi

tmp=$(mktemp)
jq '.enabledPlugins["ai-software-governance@local"] = true' "$SETTINGS_JSON" > "$tmp" && mv "$tmp" "$SETTINGS_JSON"

echo "       -> OK"
echo ""

# 4. Vérification
echo "[4/4] Vérification de l'installation..."

if [ -f "$PLUGIN_DIR/skills/$PLUGIN_NAME/SKILL.md" ] && \
   jq -e '.plugins["ai-software-governance@local"]' "$PLUGINS_JSON" > /dev/null 2>&1 && \
   jq -e '.enabledPlugins["ai-software-governance@local"]' "$SETTINGS_JSON" > /dev/null 2>&1; then
  echo "       -> Tout est OK"
else
  echo "[ERREUR] L'installation a échoué. Vérifiez les fichiers manuellement."
  exit 1
fi

echo ""
echo "══════════════════════════════════════════════════════════"
echo "  INSTALLATION RÉUSSIE"
echo "══════════════════════════════════════════════════════════"
echo ""
echo "  Prochaines étapes :"
echo "    1. Redémarrez Claude Code"
echo "    2. Ouvrez un projet"
echo "    3. Tapez : /audit"
echo ""
echo "  Modèle recommandé : Opus (contexte 1M)"
echo "    -> /model opus"
echo ""

#!/bin/bash
# ============================================================
# Script d'installation — Interactive Functional Tester Plugin
# Pour Claude Code (CLI / Desktop / IDE) — Linux / macOS
# ============================================================

set -e

PLUGIN_NAME="interactive-functional-tester"
PLUGIN_DIR="$HOME/.claude/plugins/$PLUGIN_NAME"
PLUGINS_JSON="$HOME/.claude/plugins/installed_plugins.json"
SETTINGS_JSON="$HOME/.claude/settings.json"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "══════════════════════════════════════════════════════════"
echo "  Installation : Interactive Functional Tester v1.0.0"
echo "══════════════════════════════════════════════════════════"
echo ""

# Verifier que jq est disponible
if ! command -v jq &> /dev/null; then
  echo "[ERREUR] 'jq' est requis mais non installe."
  echo ""
  echo "  Installez-le :"
  echo "    Ubuntu/Debian : sudo apt install jq"
  echo "    Arch Linux    : sudo pacman -S jq"
  echo "    macOS         : brew install jq"
  echo "    Fedora        : sudo dnf install jq"
  echo ""
  exit 1
fi

# Verifier que Claude Code est configure
if [ ! -d "$HOME/.claude" ]; then
  echo "[ERREUR] Repertoire ~/.claude introuvable."
  echo "         Lancez Claude Code au moins une fois avant d'installer ce plugin."
  exit 1
fi

# Verifier que Docker est installe
if ! command -v docker &> /dev/null; then
  echo "[AVERTISSEMENT] Docker n'est pas installe ou pas dans le PATH."
  echo "                Ce plugin necessite Docker pour fonctionner."
  echo "                L'installation continue mais le plugin ne marchera pas sans Docker."
  echo ""
fi

# 1. Copier les fichiers du plugin
echo "[1/4] Copie des fichiers du plugin..."

if [ -d "$PLUGIN_DIR" ]; then
  echo "       Le plugin existe deja. Mise a jour..."
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
  '.plugins["interactive-functional-tester@local"] = [{
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
jq '.enabledPlugins["interactive-functional-tester@local"] = true' "$SETTINGS_JSON" > "$tmp" && mv "$tmp" "$SETTINGS_JSON"

echo "       -> OK"
echo ""

# 4. Verification
echo "[4/4] Verification de l'installation..."

if [ -f "$PLUGIN_DIR/skills/$PLUGIN_NAME/SKILL.md" ] && \
   jq -e '.plugins["interactive-functional-tester@local"]' "$PLUGINS_JSON" > /dev/null 2>&1 && \
   jq -e '.enabledPlugins["interactive-functional-tester@local"]' "$SETTINGS_JSON" > /dev/null 2>&1; then
  echo "       -> Tout est OK"
else
  echo "[ERREUR] L'installation a echoue. Verifiez les fichiers manuellement."
  exit 1
fi

echo ""
echo "══════════════════════════════════════════════════════════"
echo "  INSTALLATION REUSSIE"
echo "══════════════════════════════════════════════════════════"
echo ""
echo "  Prochaines etapes :"
echo "    1. Redemarrez Claude Code"
echo "    2. Ouvrez un projet avec un cahier de tests"
echo "    3. Tapez : /start-tests"
echo ""
echo "  Prerequis runtime :"
echo "    - Docker + Docker Compose installes"
echo "    - Un fichier de tests dans le projet (TESTS.md, etc.)"
echo ""

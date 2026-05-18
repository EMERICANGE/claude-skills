#!/bin/bash
set -e

PLUGIN_NAME="mcp-builder"
PLUGIN_DIR="$HOME/.claude/plugins/$PLUGIN_NAME"
PLUGINS_JSON="$HOME/.claude/plugins/installed_plugins.json"
SETTINGS_JSON="$HOME/.claude/settings.json"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "══════════════════════════════════════════════════════════"
echo "  Installation : MCP Builder v1.0.0"
echo "══════════════════════════════════════════════════════════"
echo ""

if ! command -v jq &> /dev/null; then
  echo "[ERREUR] 'jq' est requis. Installez-le : sudo apt install jq / brew install jq"
  exit 1
fi

if [ ! -d "$HOME/.claude" ]; then
  echo "[ERREUR] ~/.claude introuvable. Lancez Claude Code une premiere fois."
  exit 1
fi

echo "[1/4] Copie des fichiers..."
[ -d "$PLUGIN_DIR" ] && rm -rf "$PLUGIN_DIR"
mkdir -p "$PLUGIN_DIR/skills/$PLUGIN_NAME"
cp "$SCRIPT_DIR/package.json" "$PLUGIN_DIR/"
cp "$SCRIPT_DIR/skills/$PLUGIN_NAME/SKILL.md" "$PLUGIN_DIR/skills/$PLUGIN_NAME/"
cp "$SCRIPT_DIR/README.md" "$PLUGIN_DIR/" 2>/dev/null || true
echo "       -> $PLUGIN_DIR"
echo ""

echo "[2/4] Enregistrement dans installed_plugins.json..."
mkdir -p "$HOME/.claude/plugins"
[ ! -f "$PLUGINS_JSON" ] && echo '{"version": 2, "plugins": {}}' > "$PLUGINS_JSON"
INSTALL_DATE=$(date -u +"%Y-%m-%dT%H:%M:%S.000Z")
tmp=$(mktemp)
jq --arg path "$PLUGIN_DIR" --arg date "$INSTALL_DATE" \
  ".plugins[\"${PLUGIN_NAME}@local\"] = [{\"scope\": \"user\", \"installPath\": \$path, \"version\": \"1.0.0\", \"installedAt\": \$date, \"lastUpdated\": \$date}]" \
  "$PLUGINS_JSON" > "$tmp" && mv "$tmp" "$PLUGINS_JSON"
echo "       -> OK"
echo ""

echo "[3/4] Activation dans settings.json..."
[ ! -f "$SETTINGS_JSON" ] && echo '{"enabledPlugins": {}}' > "$SETTINGS_JSON"
tmp=$(mktemp)
jq ".enabledPlugins[\"${PLUGIN_NAME}@local\"] = true" "$SETTINGS_JSON" > "$tmp" && mv "$tmp" "$SETTINGS_JSON"
echo "       -> OK"
echo ""

echo "[4/4] Verification..."
if [ -f "$PLUGIN_DIR/skills/$PLUGIN_NAME/SKILL.md" ] && \
   jq -e ".plugins[\"${PLUGIN_NAME}@local\"]" "$PLUGINS_JSON" > /dev/null 2>&1; then
  echo "       -> Tout est OK"
else
  echo "[ERREUR] Installation echouee."
  exit 1
fi

echo ""
echo "══════════════════════════════════════════════════════════"
echo "  INSTALLATION REUSSIE"
echo "══════════════════════════════════════════════════════════"
echo ""
echo "  Redemarrez Claude Code, puis tapez : /mcp-build"
echo ""

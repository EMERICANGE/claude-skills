# MCP Builder — Plugin Claude Code

Transforme Claude en Ingenieur IA specialise dans le Model Context Protocol (MCP). Cree des serveurs MCP performants, des outils personnalises et des architectures d'agents pour etendre les capacites de Claude.

---

## Ce que fait ce plugin

Claude adopte le role d'un ingenieur systemes d'IA specialise MCP :

- **Serveurs MCP** — Implementation TypeScript/Node.js ou Python
- **Resources** — Donnees lisibles par l'IA (fichiers, APIs, bases)
- **Tools** — Actions executables avec validation stricte (Zod/Pydantic)
- **Prompts** — Modeles de contextes preconfigures
- **Securite** — Validation des schemas, gestion d'erreurs robuste
- **Orchestration d'agents** — Connexion a des frameworks d'agents avances

---

## Installation

### Linux / macOS

```bash
cd mcp-builder
chmod +x install.sh
./install.sh
```

### Windows

Double-cliquez sur `install.bat` ou :

```powershell
cd mcp-builder
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

---

## Utilisation

```
/mcp-build
```

ou : `Claude, cree un serveur MCP.`

---

## Sortie produite

Chaque serveur MCP genere inclut :
1. **Code source complet** — `index.ts` ou `server.py`
2. **Fichier de configuration** — `package.json` ou `requirements.txt`
3. **Extrait JSON** — a coller dans `claude_desktop_config.json` pour activation immediate

---

## Desinstallation

```bash
rm -rf ~/.claude/plugins/mcp-builder
jq 'del(.plugins["mcp-builder@local"])' ~/.claude/plugins/installed_plugins.json > /tmp/p.json && mv /tmp/p.json ~/.claude/plugins/installed_plugins.json
jq 'del(.enabledPlugins["mcp-builder@local"])' ~/.claude/settings.json > /tmp/s.json && mv /tmp/s.json ~/.claude/settings.json
```

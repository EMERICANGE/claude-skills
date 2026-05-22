# Claude Skills — Custom Marketplace

Collection de skills personnalises pour Claude Code, distribuee en tant que marketplace GitHub.

## Skills disponibles

| Skill | Commande | Description |
|-------|----------|-------------|
| `ai-software-governance` | `/audit` | Audit de gouvernance logicielle 28 phases → verdict GO/NO GO Production |
| `interactive-functional-tester` | `/start-tests` | Tests fonctionnels interactifs pas-a-pas avec orchestration Docker |
| `spring-enterprise` | `/spring-expert` | Architecte Spring Boot / DDD / Clean-Hexagonal / performances |
| `devsecops-platform` | `/devops-deploy` | Platform Engineer / K8s / CI/CD securise / FinOps |
| `mcp-builder` | `/mcp-build` | Createur de serveurs MCP (Model Context Protocol) pour Claude |
| `startup-cto` | `/cto-vision` | CTO virtuel / cadrage MVP / budgetisation / Go-To-Market |
| `evolution-architect` | `/propose-evolution` | Propositions d'ameliorations argumentees + implementation + audit |
| `cloud-budget-optimizer` | `/budget-optimize` | Comparatif VPS / PaaS / Serverless avec couts estimes |
| `project-brain-saver` | `/save-memory` `/resume` `/status` | Sauvegarde/reprise de session — memoire contextuelle persistante |
| `autonomous-task-loop` | `/loop-until-done` | Agent iteratif — boucle jusqu'a completion du CDC |
| `ui-experience-designer` | `/ui-design` | Expert UI/UX — analyse stack, propose concepts, implemente |
| `squad-software-factory` | `/launch-squads` | Usine multi-squads (PO, Dev, Review, QA, User, Doc) |

---

## Installation

### Methode 1 — Automatique (recommandee)

Dans Claude Code, tapez :

```
/plugin marketplace add EMERICANGE/claude-skills
```

Puis installez le plugin :

```
/plugin install claude-skills
```

Redemarrez Claude Code. Tous les skills seront disponibles.

---

### Methode 2 — Manuelle

**Etape 1 : Declarer le marketplace**

Ajoutez dans `~/.claude/settings.json` (Linux/macOS) ou `C:\Users\VOTRE_USER\.claude\settings.json` (Windows) :

```json
{
  "extraKnownMarketplaces": {
    "claude-skills": {
      "source": {
        "source": "github",
        "repo": "EMERICANGE/claude-skills"
      }
    }
  },
  "enabledPlugins": {
    "claude-skills@claude-skills": true
  }
}
```

> Si vous avez deja d'autres entrees dans `extraKnownMarketplaces` ou `enabledPlugins`, ajoutez les nouvelles cles sans supprimer les existantes.

**Etape 2 : Copier les fichiers du marketplace**

```bash
# Cloner le repo
git clone https://github.com/EMERICANGE/claude-skills.git /tmp/claude-skills

# Copier dans le dossier marketplaces de Claude Code
mkdir -p ~/.claude/plugins/marketplaces/claude-skills
cp -r /tmp/claude-skills/* ~/.claude/plugins/marketplaces/claude-skills/
cp -r /tmp/claude-skills/.claude-plugin ~/.claude/plugins/marketplaces/claude-skills/

# Copier dans le cache
mkdir -p ~/.claude/plugins/cache/claude-skills/claude-skills/1.0.0
cp -r /tmp/claude-skills/skills ~/.claude/plugins/cache/claude-skills/claude-skills/1.0.0/
cp -r /tmp/claude-skills/.claude-plugin ~/.claude/plugins/cache/claude-skills/claude-skills/1.0.0/
```

**Etape 3 : Enregistrer dans installed_plugins.json**

Ajoutez dans `~/.claude/plugins/installed_plugins.json` :

```json
"claude-skills@claude-skills": [
  {
    "scope": "user",
    "installPath": "/home/VOTRE_USER/.claude/plugins/cache/claude-skills/claude-skills/1.0.0",
    "version": "1.0.0",
    "installedAt": "2026-05-19T00:00:00.000Z",
    "lastUpdated": "2026-05-19T00:00:00.000Z"
  }
]
```

**Etape 4 : Redemarrer Claude Code**

```
/reload-plugins
```

---

### Methode 3 — Script d'installation (Linux/macOS)

```bash
#!/bin/bash
set -e

echo "=== Installation du marketplace claude-skills ==="

# Prerequis
if ! command -v jq &> /dev/null; then
  echo "[ERREUR] jq requis. Installez-le : sudo apt install jq / brew install jq"
  exit 1
fi

if [ ! -d "$HOME/.claude" ]; then
  echo "[ERREUR] ~/.claude introuvable. Lancez Claude Code une premiere fois."
  exit 1
fi

# Cloner le repo
REPO_DIR=$(mktemp -d)
git clone https://github.com/EMERICANGE/claude-skills.git "$REPO_DIR"

# Marketplace
MARKETPLACE_DIR="$HOME/.claude/plugins/marketplaces/claude-skills"
mkdir -p "$MARKETPLACE_DIR"
cp -r "$REPO_DIR"/skills "$MARKETPLACE_DIR/"
cp -r "$REPO_DIR"/.claude-plugin "$MARKETPLACE_DIR/"
cp "$REPO_DIR"/README.md "$MARKETPLACE_DIR/" 2>/dev/null || true

# Cache
CACHE_DIR="$HOME/.claude/plugins/cache/claude-skills/claude-skills/1.0.0"
mkdir -p "$CACHE_DIR"
cp -r "$REPO_DIR"/skills "$CACHE_DIR/"
cp -r "$REPO_DIR"/.claude-plugin "$CACHE_DIR/"

# installed_plugins.json
PLUGINS_JSON="$HOME/.claude/plugins/installed_plugins.json"
[ ! -f "$PLUGINS_JSON" ] && echo '{"version": 2, "plugins": {}}' > "$PLUGINS_JSON"
tmp=$(mktemp)
jq --arg path "$CACHE_DIR" '.plugins["claude-skills@claude-skills"] = [{
  "scope": "user",
  "installPath": $path,
  "version": "1.0.0",
  "installedAt": "2026-05-19T00:00:00.000Z",
  "lastUpdated": "2026-05-19T00:00:00.000Z"
}]' "$PLUGINS_JSON" > "$tmp" && mv "$tmp" "$PLUGINS_JSON"

# settings.json
SETTINGS_JSON="$HOME/.claude/settings.json"
[ ! -f "$SETTINGS_JSON" ] && echo '{}' > "$SETTINGS_JSON"
tmp=$(mktemp)
jq '.extraKnownMarketplaces["claude-skills"] = {"source": {"source": "github", "repo": "EMERICANGE/claude-skills"}} | .enabledPlugins["claude-skills@claude-skills"] = true' "$SETTINGS_JSON" > "$tmp" && mv "$tmp" "$SETTINGS_JSON"

# Nettoyage
rm -rf "$REPO_DIR"

echo ""
echo "=== INSTALLATION REUSSIE ==="
echo "Redemarrez Claude Code ou tapez /reload-plugins"
echo ""
```

---

## Mise a jour

Pour mettre a jour les skills apres un `git pull` :

```bash
cd /tmp && git clone https://github.com/EMERICANGE/claude-skills.git
cp -r /tmp/claude-skills/skills/* ~/.claude/plugins/cache/claude-skills/claude-skills/1.0.0/skills/
cp -r /tmp/claude-skills/skills/* ~/.claude/plugins/marketplaces/claude-skills/skills/
rm -rf /tmp/claude-skills
```

Puis `/reload-plugins` dans Claude Code.

---

## Prerequis

- **Claude Code** installe et fonctionnel (CLI, Desktop, ou IDE extension)
- **Claude Opus** recommande pour les analyses approfondies (contexte 1M tokens)
- **Docker** requis pour le skill `interactive-functional-tester`
- **jq** requis pour le script d'installation automatique

---

## Structure du repo

```
claude-skills/
├── .claude-plugin/
│   └── marketplace.json        # Manifeste du marketplace
├── skills/
│   ├── ai-software-governance/SKILL.md
│   ├── cloud-budget-optimizer/SKILL.md
│   ├── devsecops-platform/SKILL.md
│   ├── evolution-architect/SKILL.md
│   ├── interactive-functional-tester/SKILL.md
│   ├── mcp-builder/SKILL.md
│   ├── project-brain-saver/SKILL.md
│   ├── spring-enterprise/SKILL.md
│   ├── startup-cto/SKILL.md
│   ├── autonomous-task-loop/SKILL.md
│   ├── ui-experience-designer/SKILL.md
│   └── squad-software-factory/SKILL.md
└── README.md
```

---

## Desinstallation

```bash
# Supprimer le cache et le marketplace
rm -rf ~/.claude/plugins/cache/claude-skills
rm -rf ~/.claude/plugins/marketplaces/claude-skills

# Retirer des fichiers JSON (necessite jq)
jq 'del(.plugins["claude-skills@claude-skills"])' ~/.claude/plugins/installed_plugins.json > /tmp/p.json && mv /tmp/p.json ~/.claude/plugins/installed_plugins.json
jq 'del(.enabledPlugins["claude-skills@claude-skills"]) | del(.extraKnownMarketplaces["claude-skills"])' ~/.claude/settings.json > /tmp/s.json && mv /tmp/s.json ~/.claude/settings.json
```

---

## Licence

Usage interne — distribution libre au sein de l'equipe.

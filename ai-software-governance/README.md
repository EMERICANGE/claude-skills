# AI Software Governance — Plugin Claude Code

Plugin de gouvernance logicielle complète pilotée par IA pour Claude Code. Exécute un audit exhaustif de 28 phases sur n'importe quel projet : architecture, sécurité, qualité, DevOps, Docker, Kubernetes, CI/CD, observabilité, FinOps, et délivre un verdict **GO / NO GO PRODUCTION**.

---

## Prérequis

- **Claude Code** installé et fonctionnel (CLI, Desktop, ou IDE extension)
- Un abonnement Claude avec accès aux modèles (Opus recommandé pour la profondeur d'analyse)

---

## Installation

### Méthode 1 — Copie manuelle (recommandée)

**Étape 1 : Copier le dossier du plugin**

```bash
# Créer le répertoire des plugins si inexistant
mkdir -p ~/.claude/plugins

# Copier le dossier du plugin (depuis une clé USB, un partage réseau, ou git clone)
cp -r ai-software-governance ~/.claude/plugins/
```

La structure finale doit être :

```
~/.claude/plugins/ai-software-governance/
├── package.json
├── README.md
└── skills/
    └── ai-software-governance/
        └── SKILL.md
```

**Étape 2 : Enregistrer le plugin dans `installed_plugins.json`**

Ouvrir le fichier `~/.claude/plugins/installed_plugins.json` et ajouter cette entrée dans l'objet `"plugins"` :

```json
"ai-software-governance@local": [
  {
    "scope": "user",
    "installPath": "/home/VOTRE_USER/.claude/plugins/ai-software-governance",
    "version": "1.0.0",
    "installedAt": "2026-05-18T00:00:00.000Z",
    "lastUpdated": "2026-05-18T00:00:00.000Z"
  }
]
```

> Remplacez `VOTRE_USER` par votre nom d'utilisateur système.

Si le fichier `installed_plugins.json` n'existe pas, créez-le :

```json
{
  "version": 2,
  "plugins": {
    "ai-software-governance@local": [
      {
        "scope": "user",
        "installPath": "/home/VOTRE_USER/.claude/plugins/ai-software-governance",
        "version": "1.0.0",
        "installedAt": "2026-05-18T00:00:00.000Z",
        "lastUpdated": "2026-05-18T00:00:00.000Z"
      }
    ]
  }
}
```

**Étape 3 : Activer le plugin dans `settings.json`**

Ouvrir `~/.claude/settings.json` et ajouter dans l'objet `"enabledPlugins"` :

```json
"enabledPlugins": {
  "ai-software-governance@local": true
}
```

**Étape 4 : Redémarrer Claude Code**

Fermez et relancez Claude Code. Le skill sera disponible.

---

### Méthode 2 — Script d'installation automatique

Créez et exécutez ce script :

```bash
#!/bin/bash
# install-governance-plugin.sh

PLUGIN_DIR="$HOME/.claude/plugins/ai-software-governance"
PLUGINS_JSON="$HOME/.claude/plugins/installed_plugins.json"
SETTINGS_JSON="$HOME/.claude/settings.json"

echo "=== Installation du plugin AI Software Governance ==="

# 1. Copier les fichiers
mkdir -p "$PLUGIN_DIR/skills/ai-software-governance"
cp package.json "$PLUGIN_DIR/"
cp skills/ai-software-governance/SKILL.md "$PLUGIN_DIR/skills/ai-software-governance/"

echo "[OK] Fichiers copiés dans $PLUGIN_DIR"

# 2. Enregistrer dans installed_plugins.json
if [ ! -f "$PLUGINS_JSON" ]; then
  cat > "$PLUGINS_JSON" << EOF
{
  "version": 2,
  "plugins": {}
}
EOF
fi

# Ajouter l'entrée (nécessite jq)
if command -v jq &> /dev/null; then
  tmp=$(mktemp)
  jq --arg path "$PLUGIN_DIR" '.plugins["ai-software-governance@local"] = [{
    "scope": "user",
    "installPath": $path,
    "version": "1.0.0",
    "installedAt": "2026-05-18T00:00:00.000Z",
    "lastUpdated": "2026-05-18T00:00:00.000Z"
  }]' "$PLUGINS_JSON" > "$tmp" && mv "$tmp" "$PLUGINS_JSON"
  echo "[OK] Plugin enregistré dans installed_plugins.json"
else
  echo "[!] jq non installé — ajoutez manuellement l'entrée dans $PLUGINS_JSON"
  echo "    Installez jq : sudo apt install jq (ou brew install jq)"
fi

# 3. Activer dans settings.json
if [ -f "$SETTINGS_JSON" ]; then
  if command -v jq &> /dev/null; then
    tmp=$(mktemp)
    jq '.enabledPlugins["ai-software-governance@local"] = true' "$SETTINGS_JSON" > "$tmp" && mv "$tmp" "$SETTINGS_JSON"
    echo "[OK] Plugin activé dans settings.json"
  else
    echo "[!] Ajoutez manuellement dans $SETTINGS_JSON :"
    echo '    "ai-software-governance@local": true dans enabledPlugins'
  fi
else
  echo "[!] settings.json introuvable — le plugin sera activé au premier lancement"
fi

echo ""
echo "=== Installation terminée ==="
echo "Redémarrez Claude Code, puis utilisez : /audit"
```

#### Linux / macOS

```bash
cd ai-software-governance
chmod +x install.sh
./install.sh
```

#### Windows

**Option A — Double-clic :**

Double-cliquez sur `install.bat`. Le script PowerShell se lance automatiquement.

**Option B — PowerShell :**

```powershell
cd ai-software-governance
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

> Si vous obtenez une erreur de politique d'exécution, ouvrez PowerShell en administrateur et lancez :
> ```powershell
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

**Note Windows :** Les fichiers de configuration Claude Code sur Windows se trouvent dans :
- `C:\Users\VOTRE_USER\.claude\settings.json`
- `C:\Users\VOTRE_USER\.claude\plugins\installed_plugins.json`

---

## Utilisation

Une fois installé, ouvrez Claude Code dans n'importe quel projet et lancez l'audit :

```
/audit
```

ou tapez :

```
Claude, lance l'audit de gouvernance.
```

### Ce que fait l'audit

| Phase | Domaine | Livrable |
|-------|---------|----------|
| 0 | Découverte du stack | `stack_inventory.md` |
| 1 | Audit fonctionnel | `functional_report.md` |
| 2 | Architecture | `architecture_report.md` |
| 3 | Qualité du code | `quality_report.md` |
| 4 | Sécurité OWASP | `security_report.md` |
| 5 | Stratégie QA | `qa_report.md` |
| 6 | Tests E2E Cypress | `cypress/` |
| 7 | Specs Gherkin BDD | `gherkin/` |
| 8 | Performance | `performance_report.md` |
| 9 | Docker | `docker_report.md` |
| 10 | Docker Compose | `compose_report.md` |
| 11 | Kubernetes | `k8s_report.md` |
| 12 | Sécurité K8s | `k8s_security.md` |
| 13 | Pipelines DevOps | `devops_report.md` |
| 14 | GitLab CI | `gitlab_report.md` |
| 15 | Jenkins | `jenkins_report.md` |
| 16 | GitHub Actions | `github_actions_report.md` |
| 17 | Observabilité | `observability_report.md` |
| 18 | Helm Charts | `helm_report.md` |
| 19 | IaC (Terraform/Ansible) | `iac_report.md` |
| 20 | FinOps | `finops_report.md` |
| 21* | Flutter | `flutter_report.md` |
| 22* | NativeScript | `nativescript_report.md` |
| 23* | Android Native | `android_report.md` |
| 24* | Angular | `angular_report.md` |
| 25* | Electron | `electron_report.md` |
| 26* | Desktop Readiness | `desktop_readiness.md` |
| 27* | Mobile Readiness | `mobile_readiness.md` |
| 28 | Production Readiness | `production_readiness.md` |

> \* Phases conditionnelles — activées uniquement si le stack correspondant est détecté.

**Rapport final :** `software_governance_report.md` — scores /100 par domaine + verdict GO/NO GO.

---

## Désinstallation

```bash
# Supprimer le dossier
rm -rf ~/.claude/plugins/ai-software-governance

# Retirer l'entrée de installed_plugins.json (avec jq)
jq 'del(.plugins["ai-software-governance@local"])' \
  ~/.claude/plugins/installed_plugins.json > /tmp/plugins.json \
  && mv /tmp/plugins.json ~/.claude/plugins/installed_plugins.json

# Retirer de settings.json (avec jq)
jq 'del(.enabledPlugins["ai-software-governance@local"])' \
  ~/.claude/settings.json > /tmp/settings.json \
  && mv /tmp/settings.json ~/.claude/settings.json
```

---

## Dépannage

| Problème | Solution |
|----------|----------|
| Le skill n'apparaît pas après redémarrage | Vérifiez que `installPath` dans `installed_plugins.json` pointe vers le bon chemin absolu |
| Erreur "plugin not found" | Vérifiez que `"ai-software-governance@local": true` est dans `enabledPlugins` de `settings.json` |
| L'audit ne se déclenche pas | Assurez-vous de taper exactement `/audit` ou la phrase de déclenchement |
| Audit incomplet / timeout | Utilisez le modèle Opus avec le contexte 1M pour les gros projets |

---

## Modèle recommandé

Pour un audit complet, utilisez **Claude Opus** (contexte 1M tokens). Les projets volumineux nécessitent la capacité de contexte étendue pour analyser l'ensemble du code source.

```
/model opus
```

---

## Licence

Usage interne — distribution libre au sein de l'équipe.

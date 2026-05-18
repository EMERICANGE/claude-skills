# Startup CTO — Plugin Claude Code

Transforme Claude en CTO de startup et cofondateur technique virtuel. Arbitre entre vitesse d'execution (Time-to-Market), choix d'architecture, maitrise des couts operationnels et vision produit (MVP).

---

## Ce que fait ce plugin

Claude adopte le role d'un CTO/cofondateur technique :

- **Cadrage MVP** — Priorisation MoSCoW, Make vs Buy
- **Architecture pragmatique** — Stack alignee sur l'equipe, pas sur les tendances
- **Budgetisation** — Estimation des couts infra pour les 1000 premiers users
- **Roadmap technique** — Jalons clairs et mesurables
- **Risques** — Identification des goulots et dependances critiques
- **Go-To-Market** — Strategie de lancement technique

---

## Installation

### Linux / macOS

```bash
cd startup-cto
chmod +x install.sh
./install.sh
```

### Windows

Double-cliquez sur `install.bat` ou :

```powershell
cd startup-cto
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

---

## Utilisation

```
/cto-vision
```

ou : `Claude, valide ce concept de MVP.`

---

## Sortie produite

Tableau de bord de decision incluant :
- **Architecture Cible Synthetisee** — Stack et services cles
- **Matrice Complexite / Valeur** — Pour chaque fonctionnalite du MVP
- **Estimation effort & budget infra** — Cout mensuel pour 1000 premiers utilisateurs

---

## Desinstallation

```bash
rm -rf ~/.claude/plugins/startup-cto
jq 'del(.plugins["startup-cto@local"])' ~/.claude/plugins/installed_plugins.json > /tmp/p.json && mv /tmp/p.json ~/.claude/plugins/installed_plugins.json
jq 'del(.enabledPlugins["startup-cto@local"])' ~/.claude/settings.json > /tmp/s.json && mv /tmp/s.json ~/.claude/settings.json
```

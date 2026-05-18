# Claude Skill Library

Collection de plugins (skills) pour Claude Code. Chaque plugin s'installe dans `~/.claude/plugins/` et ajoute des capacites specialisees a Claude Code.

---

## Plugins disponibles

| Plugin | Description | Commande |
|--------|-------------|----------|
| [ai-software-governance](./ai-software-governance/) | Audit de gouvernance logicielle complet (28 phases) — architecture, securite, qualite, DevOps, Docker, K8s, CI/CD, observabilite, FinOps. Delivre un verdict GO / NO GO Production. | `/audit` |
| [interactive-functional-tester](./interactive-functional-tester/) | Test fonctionnel interactif pas-a-pas. Orchestre des environnements Docker a la volee, execute les tests un par un avec validation utilisateur, et corrige le code en cas d'echec. | `/start-tests` |

---

## Installation rapide

### Linux / macOS

```bash
cd <plugin>
chmod +x install.sh
./install.sh
```

### Windows

```powershell
cd <plugin>
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

Ou double-cliquez sur `install.bat`.

Consultez le README de chaque plugin pour l'installation manuelle et le depannage.

---

## Prerequis

- **Claude Code** installe et fonctionnel (CLI, Desktop, ou IDE extension)
- **Claude Opus** recommande pour les analyses approfondies (contexte 1M tokens)
- **Docker** requis pour le plugin interactive-functional-tester

---

## Structure

```
Claude Skill Library/
├── ai-software-governance/
│   ├── package.json
│   ├── install.sh / install.ps1 / install.bat
│   ├── README.md
│   └── skills/ai-software-governance/SKILL.md
├── interactive-functional-tester/
│   ├── package.json
│   ├── install.sh / install.ps1 / install.bat
│   ├── README.md
│   └── skills/interactive-functional-tester/SKILL.md
└── README.md
```

---

## Licence

Usage interne — distribution libre au sein de l'equipe.

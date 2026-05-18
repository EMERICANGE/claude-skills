# Claude Skill Library

Collection de plugins (skills) pour Claude Code. Chaque plugin s'installe dans `~/.claude/plugins/` et ajoute des capacites specialisees a Claude Code.

---

## Plugins disponibles

| Plugin | Description | Commande |
|--------|-------------|----------|
| [ai-software-governance](./ai-software-governance/) | Audit de gouvernance logicielle complet (28 phases) — architecture, securite, qualite, DevOps, Docker, K8s, CI/CD, observabilite, FinOps. Delivre un verdict GO / NO GO Production. | `/audit` |
| [devsecops-platform](./devsecops-platform/) | Ingenieur Platform et DevSecOps senior. Automatisation IaC, durcissement conteneurs, orchestration Kubernetes, pipelines CI/CD securises et optimisation FinOps. | — |
| [interactive-functional-tester](./interactive-functional-tester/) | Test fonctionnel interactif pas-a-pas. Orchestre des environnements Docker a la volee, execute les tests un par un avec validation utilisateur, et corrige le code en cas d'echec. | `/start-tests` |
| [mcp-builder](./mcp-builder/) | Ingenieur IA specialise dans l'extension des capacites de Claude via MCP. Cree des serveurs MCP performants, des outils personnalises et des architectures d'agents. | — |
| [spring-enterprise](./spring-enterprise/) | Architecte et Tech Lead expert Spring Boot moderne — architectures d'entreprise distribuees, DDD, Clean/Hexagonal et performances. | — |
| [startup-cto](./startup-cto/) | CTO de startup et cofondateur technique virtuel. Arbitre entre vitesse d'execution, choix d'architecture, maitrise des couts et vision produit (MVP). | — |

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
├── devsecops-platform/
├── interactive-functional-tester/
├── mcp-builder/
├── spring-enterprise/
├── startup-cto/
└── README.md
```

Chaque plugin suit la meme structure :

```
<plugin>/
├── package.json
├── install.sh / install.ps1 / install.bat
├── README.md
└── skills/<plugin>/SKILL.md
```

---

## Licence

Usage interne — distribution libre au sein de l'equipe.

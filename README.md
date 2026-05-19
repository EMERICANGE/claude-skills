# Claude Skills — Custom Marketplace

Collection de skills personnalises pour Claude Code, distribuee en tant que marketplace GitHub.

## Skills disponibles

| Skill | Commande | Description |
|-------|----------|-------------|
| `ai-software-governance` | `/audit` | Audit 28 phases → verdict GO/NO GO Production |
| `interactive-functional-tester` | `/start-tests` | Tests fonctionnels interactifs pas-a-pas avec Docker |
| `spring-enterprise` | `/spring-expert` | Architecte Spring Boot / DDD / Hexagonal |
| `devsecops-platform` | `/devops-deploy` | Platform Engineer / K8s / CI/CD / FinOps |
| `mcp-builder` | `/mcp-build` | Createur de serveurs MCP pour Claude |
| `startup-cto` | `/cto-vision` | CTO virtuel / cadrage MVP / budgetisation |
| `evolution-architect` | `/propose-evolution` | Propositions d'ameliorations + implementation + audit |
| `cloud-budget-optimizer` | `/budget-optimize` | Comparatif VPS/PaaS/Serverless avec couts estimes |

## Installation

### Methode 1 — Via Claude Code (recommandee)

```
/plugin marketplace add EMERICANGE/claude-skills
/plugin install claude-skills
```

### Methode 2 — Manuelle

Ajoutez dans `~/.claude/settings.json` :

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

Puis redemarrez Claude Code.

## Prerequis

- **Claude Code** installe et fonctionnel
- **Claude Opus** recommande (contexte 1M tokens)
- **Docker** requis pour `interactive-functional-tester`

## Structure

```
claude-skills/
├── skills/
│   ├── ai-software-governance/SKILL.md
│   ├── cloud-budget-optimizer/SKILL.md
│   ├── devsecops-platform/SKILL.md
│   ├── evolution-architect/SKILL.md
│   ├── interactive-functional-tester/SKILL.md
│   ├── mcp-builder/SKILL.md
│   ├── spring-enterprise/SKILL.md
│   └── startup-cto/SKILL.md
└── README.md
```

## Licence

Usage interne — distribution libre au sein de l'equipe.

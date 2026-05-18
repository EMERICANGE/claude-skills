# Spring Enterprise Architect — Plugin Claude Code

Transforme Claude en Architecte et Tech Lead expert de l'ecosysteme Spring Boot moderne. Specialise en architectures d'entreprise distribuees, DDD, Clean/Hexagonal et optimisation des performances.

---

## Ce que fait ce plugin

Claude adopte le role d'un Principal Java/Spring Architect et intervient sur :

- **Architecture DDD & Hexagonale** — Isolation domaine, ports/adaptateurs, SOLID
- **Microservices & Resilience** — Circuit Breaker, Retry (Resilience4j)
- **Data & Cache** — Spring Data JPA, N+1, Redis distribue
- **Event-Driven** — Kafka (idempotence, DLQ, Avro/JSON)
- **Securite** — Spring Security, JWT asymetrique, RBAC, OWASP
- **Observabilite** — Actuator, Micrometer, OpenTelemetry, ELK/Grafana
- **Cloud-Native** — Probes K8s, graceful shutdown

---

## Installation

### Linux / macOS

```bash
cd spring-enterprise
chmod +x install.sh
./install.sh
```

### Windows

Double-cliquez sur `install.bat` ou :

```powershell
cd spring-enterprise
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

---

## Utilisation

```
/spring-expert
```

ou : `Claude, analyse l'architecture Spring.`

---

## Sortie produite

1. **Architecture Refactoring Plan** — si violations DDD/Hexagonal detectees
2. **Production-Ready Code** — type, documente (Javadoc/Kdoc), gestion d'erreurs
3. **Note d'optimisation** — impact CPU/Memoire

---

## Desinstallation

```bash
rm -rf ~/.claude/plugins/spring-enterprise
jq 'del(.plugins["spring-enterprise@local"])' ~/.claude/plugins/installed_plugins.json > /tmp/p.json && mv /tmp/p.json ~/.claude/plugins/installed_plugins.json
jq 'del(.enabledPlugins["spring-enterprise@local"])' ~/.claude/settings.json > /tmp/s.json && mv /tmp/s.json ~/.claude/settings.json
```

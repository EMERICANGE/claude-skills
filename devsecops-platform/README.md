# DevSecOps Platform Engineer — Plugin Claude Code

Transforme Claude en Ingenieur Platform et DevSecOps senior. Automatisation des infrastructures (IaC), durcissement des conteneurs, orchestration Kubernetes, pipelines CI/CD securises et optimisation FinOps.

---

## Ce que fait ce plugin

Claude adopte le role d'un Platform Engineer / SRE / Expert Securite Cloud :

- **Docker** — Dockerfiles multi-stages, sans root, images minimales
- **Kubernetes & Helm** — Manifests, charts modulaires, HPA, affinite
- **CI/CD** — GitLab CI, Jenkins, GitHub Actions optimises
- **DevSecOps** — SAST/DAST, scan Trivy/Grype, detection de secrets
- **Observabilite** — Prometheus, Grafana, alertes SLI/SLO
- **FinOps** — Audit CPU/RAM, elimination du surprovisionnement

---

## Installation

### Linux / macOS

```bash
cd devsecops-platform
chmod +x install.sh
./install.sh
```

### Windows

Double-cliquez sur `install.bat` ou :

```powershell
cd devsecops-platform
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

---

## Utilisation

```
/devops-deploy
```

ou : `Claude, prepare l'infrastructure.`

---

## Sortie produite

Tout livrable inclut une section **"Securite & Resilience"** detaillant :
- NetworkPolicies K8s
- Politiques de restart
- Limites de ressources
- Mesures de protection appliquees

---

## Desinstallation

```bash
rm -rf ~/.claude/plugins/devsecops-platform
jq 'del(.plugins["devsecops-platform@local"])' ~/.claude/plugins/installed_plugins.json > /tmp/p.json && mv /tmp/p.json ~/.claude/plugins/installed_plugins.json
jq 'del(.enabledPlugins["devsecops-platform@local"])' ~/.claude/settings.json > /tmp/s.json && mv /tmp/s.json ~/.claude/settings.json
```

# Interactive Functional Tester — Plugin Claude Code

Plugin de test fonctionnel interactif pour Claude Code. Orchestre de vrais environnements Docker a la volee, execute les tests un par un en collaboration avec l'utilisateur, et optimise la memoire en demarrant/arretant les conteneurs par cas de test.

---

## Fonctionnement

Ce plugin transforme Claude en **Ingenieur QA** qui :

1. Charge le cahier de tests fonctionnels du projet
2. Demarre uniquement les conteneurs Docker necessaires pour chaque test
3. Prepare les donnees (injection en base, pre-remplissage)
4. Guide l'utilisateur pour les actions manuelles (clics, verifications visuelles)
5. Attend la validation avant de passer au test suivant
6. Arrete les conteneurs apres chaque test pour economiser la RAM
7. Corrige le code en cas d'echec et relance le test

---

## Prerequis

- **Claude Code** installe et fonctionnel
- **Docker** et **Docker Compose** installes sur la machine
- Un fichier de cahier de tests dans le projet (ex: `tests/functional-tests.md`, `TESTS.md`, etc.)

---

## Installation

### Linux / macOS

```bash
cd interactive-functional-tester
chmod +x install.sh
./install.sh
```

### Windows

**Option A — Double-clic :**

Double-cliquez sur `install.bat`.

**Option B — PowerShell :**

```powershell
cd interactive-functional-tester
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

> Si erreur de politique d'execution :
> ```powershell
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

### Installation manuelle

Si vous preferez installer sans script :

**1. Copier le dossier :**

```bash
cp -r interactive-functional-tester ~/.claude/plugins/
```

**2. Ajouter dans `~/.claude/plugins/installed_plugins.json` :**

```json
"interactive-functional-tester@local": [
  {
    "scope": "user",
    "installPath": "/home/VOTRE_USER/.claude/plugins/interactive-functional-tester",
    "version": "1.0.0",
    "installedAt": "2026-05-18T00:00:00.000Z",
    "lastUpdated": "2026-05-18T00:00:00.000Z"
  }
]
```

**3. Ajouter dans `~/.claude/settings.json` → `enabledPlugins` :**

```json
"interactive-functional-tester@local": true
```

**4. Redemarrer Claude Code.**

> **Windows :** remplacez `~/.claude` par `C:\Users\VOTRE_USER\.claude`

---

## Utilisation

Ouvrez Claude Code dans votre projet, puis :

```
/start-tests
```

ou tapez :

```
Lance le cahier de test fonctionnel.
```

### Deroulement d'une session

```
┌─────────────────────────────────────────────┐
│  CAS DE TEST 1 : Connexion utilisateur      │
├─────────────────────────────────────────────┤
│  1. Docker : postgres + backend demarres    │
│  2. Claude : compte test cree en base       │
│  3. Vous : cliquez "Se connecter", verifiez │
│     que le dashboard s'affiche              │
├─────────────────────────────────────────────┤
│  En attente de votre retour : OK ?          │
└─────────────────────────────────────────────┘
         │
         ▼ (vous repondez "ok")
┌─────────────────────────────────────────────┐
│  Nettoyage Docker...                        │
│  CAS DE TEST 2 : Creation d'un produit     │
│  ...                                        │
└─────────────────────────────────────────────┘
```

### En cas d'erreur

Decrivez simplement le probleme :

```
Non, j'ai une erreur 500 quand je clique sur "Valider"
```

Claude va :
1. Analyser le code/logs
2. Appliquer la correction
3. Relancer le meme test depuis le debut

---

## Regles cles

| Regle | Description |
|-------|-------------|
| Un test a la fois | Jamais de liste de resultats en avance |
| Validation obligatoire | Claude attend votre "OK" avant de continuer |
| Zero mock | Toujours le vrai backend, la vraie base |
| Docker econome | Conteneurs demarres/arretes par test |
| Correction en boucle | Test KO → fix → relance → jusqu'a OK |

---

## Format du cahier de tests

Le plugin cherche un fichier de tests dans votre projet. Format recommande :

```markdown
# Cahier de Tests Fonctionnels

## TEST-001 : Connexion utilisateur
- Preconditions : compte existant en base
- Actions : aller sur /login, saisir email/mdp, cliquer Connexion
- Resultat attendu : redirection vers /dashboard

## TEST-002 : Creation d'un produit
- Preconditions : utilisateur connecte avec role ADMIN
- Actions : aller sur /products/new, remplir le formulaire, cliquer Enregistrer
- Resultat attendu : produit visible dans la liste, toast de confirmation
```

---

## Desinstallation

```bash
# Linux/macOS
rm -rf ~/.claude/plugins/interactive-functional-tester
# Retirer des JSON avec jq :
jq 'del(.plugins["interactive-functional-tester@local"])' ~/.claude/plugins/installed_plugins.json > /tmp/p.json && mv /tmp/p.json ~/.claude/plugins/installed_plugins.json
jq 'del(.enabledPlugins["interactive-functional-tester@local"])' ~/.claude/settings.json > /tmp/s.json && mv /tmp/s.json ~/.claude/settings.json
```

```powershell
# Windows PowerShell
Remove-Item -Recurse -Force "$env:USERPROFILE\.claude\plugins\interactive-functional-tester"
# Puis retirez manuellement les entrees des fichiers JSON
```

---

## Depannage

| Probleme | Solution |
|----------|----------|
| Le skill ne se declenche pas | Verifiez que le plugin est dans `enabledPlugins` de `settings.json` |
| Docker non trouve | Installez Docker et ajoutez votre user au groupe docker |
| Erreur "no test file found" | Creez un cahier de tests dans votre projet (`TESTS.md` ou `tests/`) |
| RAM saturee | Le plugin arrete les conteneurs apres chaque test — verifiez qu'aucun reste orphelin avec `docker ps` |

---

## Licence

Usage interne — distribution libre au sein de l'equipe.

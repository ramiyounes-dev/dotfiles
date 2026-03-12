# dotfiles

Personal dev environment for MacBook M4 (Apple Silicon). Opinionated setup for backend & distributed systems work in Python, JavaScript, Java, and COBOL.

---

## What's in here

| File | Purpose |
|------|---------|
| `.zshrc` | Shell config, aliases, plugins |
| `.gitconfig` | Git settings with delta diffs |
| `starship.toml` | Prompt config |
| `.envrc.template` | Template for per-project env vars |
| `setup.sh` | Full machine bootstrap |
| `link.sh` | Just symlink the dotfiles |

---

## Bootstrap a new machine

```bash
git clone https://github.com/ramiyounes-dev/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
source ~/.zshrc
```

That's it. The script is idempotent — safe to re-run.

---

## What gets installed

### Shell
- **zsh** with autosuggestions + syntax highlighting
- **starship** — fast, minimal prompt
- **zoxide** — smarter `cd` with frecency
- **fzf** — fuzzy finder wired to `fd`

### Core CLI
| Tool | Replaces | Why |
|------|----------|-----|
| `eza` | `ls` | Icons, git status, tree view |
| `bat` | `cat` | Syntax highlighting, git diff |
| `ripgrep` | `grep` | 10-100x faster |
| `fd` | `find` | Simpler, faster |
| `delta` | git pager | Side-by-side diffs |
| `lazygit` | git TUI | Full git in terminal |
| `just` | `make` | Sane command runner |
| `btop` | `top` | Better resource monitor |
| `httpie` | `curl` | Human-friendly HTTP |
| `jq` | — | JSON processing |

### Languages
- **Python 3.13** (via mise)
- **Node.js LTS** — JavaScript (via mise)
- **Java 21** (via mise)
- **COBOL** — GnuCOBOL (via brew)

### Python tools (via uv)
- `ruff` — linter + formatter
- `mypy` — type checker
- `pre-commit` — git hooks

### Containers
- **OrbStack** — Docker Desktop alternative, native Apple Silicon support
- **docker** — CLI client
- **docker-compose** — multi-container orchestration

### Editor
- **VSCode** with: Error Lens, GitLens, Ruff, Pylance, Copilot, Prettier, YAML, COBOL

---

## Shell aliases worth knowing

```bash
ll          # eza -la with git status
lt          # eza tree view
lg          # lazygit
dc          # docker compose
g           # git
mkcd <dir>  # mkdir + cd in one
gcom <msg>  # git add -A && git commit -m
port <n>    # what's running on port N
```

---

## Per-project environments

Copy `.envrc.template` into any project:

```bash
cp ~/dotfiles/.envrc.template .envrc
direnv allow
```

Variables auto-load when you `cd` in, unload when you leave.

---

## Java projects

```bash
mkdir my-app && cd my-app
mise use java@21
```

## Python projects

```bash
mkdir my-api && cd my-api
mise use python@3.13
uv init
uv add fastapi uvicorn
uv add --dev ruff mypy pytest
```

---

## Git

delta is configured as the default pager — diffs are side-by-side with syntax highlighting.

Useful aliases in `.gitconfig`:

```bash
git lg      # pretty graph log
git undo    # undo last commit (keep changes staged)
git st      # status
```

---

## Maintenance

```bash
brew upgrade                              # update all homebrew packages
mise upgrade                             # update language runtimes
uv tool upgrade --all                    # update python tools
```

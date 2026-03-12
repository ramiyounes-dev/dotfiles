# Cheatsheet

Quick reference for day-to-day commands.

---

## New project

### Python
```bash
mkdir my-api && cd my-api
mise use python@3.13
uv init
uv add <packages>
uv add --dev ruff mypy pytest
```

### Node (JavaScript)
```bash
mkdir my-app && cd my-app
mise use node@lts
npm init -y
```

### Java
```bash
mkdir my-app && cd my-app
mise use java@21
```

### COBOL
```bash
mkdir my-prog && cd my-prog
touch hello.cbl
cobc -x hello.cbl -o hello
./hello
```

---

## mise

```bash
mise use python@3.13     # pin version for this project
mise use java@21         # pin java for this project
mise current             # show active versions
mise list                # show all installed
mise upgrade             # update everything
```

---

## uv (Python)

```bash
uv init                  # new project
uv add fastapi           # add dependency
uv add --dev pytest      # add dev dependency
uv sync                  # install from lockfile
uv run python main.py    # run with managed env
uv tool install ruff     # install global CLI tool
uv tool upgrade --all    # update all tools
```

---

## direnv

```bash
cp ~/dotfiles/.envrc.template .envrc
# edit .envrc
direnv allow             # approve it
# variables load on cd-in, unload on cd-out
```

---

## docker / OrbStack

```bash
docker ps
docker compose up -d
docker compose logs -f <service>
docker compose down
docker build -t myapp .
docker exec -it <container> sh
```

---

## git

```bash
g st                     # status
g lg                     # pretty graph log
g undo                   # undo last commit, keep changes
g co -b feature/xyz      # new branch
lazygit                  # full TUI
```

---

## Search & navigation

```bash
rg "search"              # search file contents
rg "todo" --type py      # filter by file type
fd "*.go"                # find files
fd test --type d         # find directories
z <partial-path>         # jump with zoxide
zi                       # interactive zoxide picker
```

---

## HTTP

```bash
http GET localhost:8000/api
http POST localhost:8000/api key=value
http GET api.github.com/users/ramiyounes-dev
```

---

## Shell functions

```bash
mkcd my-dir              # mkdir + cd
gcom "fix: auth bug"     # git add -A + commit
port 8080                # see what's on a port
path                     # print PATH line by line
```

---

## Database

```bash
pgcli postgres://localhost:5432/mydb
redis-cli
redis-cli monitor        # watch live commands
```

---

## Next machine

```bash
git clone https://github.com/ramiyounes-dev/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./setup.sh
source ~/.zshrc
gh auth login
```

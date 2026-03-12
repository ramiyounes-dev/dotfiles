# Rami Younes - ZSH Configuration
# MacBook M-series | Backend & Distributed Systems

# --- Path & Homebrew ---
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$HOME/.local/bin:$PATH"

# --- Tool Initializations ---
eval "$(mise activate zsh)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# --- Navigation ---
alias ..='cd ..'
alias ...='cd ../'
alias ....='cd ../../..'
alias ~='cd ~'

# --- Modern ls with eza ---
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias la='eza -a --icons'
alias lt='eza --tree --icons --level=2'
alias llt='eza --tree --icons -la --level=2'

# --- Better defaults ---
alias cat='bat --paging=never'
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias df='df -h'
alias du='du -h'
alias top='btop'

# --- Dev shortcuts ---
alias k='kubectl'
alias d='docker'
alias dc='docker compose'
alias g='git'
alias lg='lazygit'
alias py='python'
alias pip='uv pip'

# --- FZF Configuration ---
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --info=inline
  --bind "ctrl-y:execute-silent(echo {} | pbcopy)"
'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- Zsh Plugins ---
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- History ---
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# --- Shell Options ---
setopt AUTO_CD
setopt NO_BEEP
setopt CORRECT

# --- Useful Functions ---
# Create dir and cd into it
mkcd() { mkdir -p "$1" && cd "$1"; }

# Quick git commit
gcom() { git add -A && git commit -m "$*"; }

# Find process on port
port() { lsof -i ":$1"; }

# Show PATH entries one per line
path() { echo "$PATH" | tr ':' '\n'; }
export PATH="$HOME/.local/bin:$PATH"

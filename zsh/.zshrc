# ~/.zshrc - Zsh Configuration with Oh-My-Zsh

# ============================================================================
# Oh-My-Zsh Configuration
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Completion settings
CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Update settings
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

# Git completion
zstyle ':completion:*:*:git:*' script ~/.completion/git/git-completion.sh

# History
HISTSIZE=20000
SAVEHIST=20000
HISTFILE=~/.zsh_history

# Plugins (git plugin provides all git aliases: gst, gd, ga, gc, gp, gl, gco, gsw, etc.)
plugins=(
    git
    python
    docker
    zsh-vi-mode
    zsh-syntax-highlighting
    fast-syntax-highlighting
    zsh-autosuggestions
    pdm
    gwt
)

# ============================================================================
# Vi Mode (additional settings beyond zsh-vi-mode plugin)
# ============================================================================
zmodload -i zsh/complist
zstyle ':completion:*' menuselect
bindkey -v
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# ============================================================================
# Environment
# ============================================================================
export EDITOR='nvim'

# Aliases
alias vim='nvim'
alias v='nvim'
alias cc='claude-chill claude'

# Zsh options
setopt nocaseglob  # Case insensitive globbing
setopt correct     # Spelling correction

# ============================================================================
# Tool Integrations
# ============================================================================

# Conda
if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    . "$HOME/miniconda3/etc/profile.d/conda.sh"
else
    export PATH="$HOME/miniconda3/bin:$PATH"
fi

# Google Cloud SDK
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && source "$HOME/google-cloud-sdk/path.zsh.inc"
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && source "$HOME/google-cloud-sdk/completion.zsh.inc"

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# uv (Python package manager)
command -v uv &>/dev/null && eval "$(uv generate-shell-completion zsh)"

# atuin (shell history)
command -v atuin &>/dev/null && eval "$(atuin init zsh)"

# zoxide (smarter cd)
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# sesh (tmux session manager)
command -v sesh &>/dev/null && eval "$(sesh completion zsh)"

# ============================================================================
# PATH Configuration
# ============================================================================
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Build flags for Homebrew libraries
export PKG_CONFIG_PATH="/opt/homebrew/lib/pkgconfig"
export CFLAGS="-I/opt/homebrew/include ${CFLAGS:-}"
export LDFLAGS="-L/opt/homebrew/lib ${LDFLAGS:-}"

# libpostal
export LIBPOSTAL_DATA_DIR=/opt/homebrew/share/libpostal

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# ============================================================================
# Custom Settings
# ============================================================================
export ENABLE_LSP_TOOLS=1
export GWT_COPY_DIRS=".serena"

# ============================================================================
# Local Overrides (machine-specific, not tracked in git)
# ============================================================================
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

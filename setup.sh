#!/usr/bin/env bash
# setup.sh - Cross-platform terminal configuration installer
# Supports macOS (Homebrew) and Linux (apt, dnf, pacman)

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory (where this repo is cloned)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ============================================================================
# Helper Functions
# ============================================================================

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

command_exists() { command -v "$1" &>/dev/null; }

backup_file() {
    local file="$1"
    if [[ -e "$file" && ! -L "$file" ]]; then
        local backup="${file}.backup.$(date +%Y%m%d%H%M%S)"
        info "Backing up existing $file to $backup"
        mv "$file" "$backup"
    elif [[ -L "$file" ]]; then
        info "Removing existing symlink $file"
        rm "$file"
    fi
}

create_symlink() {
    local src="$1"
    local dest="$2"
    backup_file "$dest"
    ln -sf "$src" "$dest"
    success "Linked $dest -> $src"
}

# ============================================================================
# OS Detection
# ============================================================================

detect_os() {
    case "$(uname -s)" in
        Darwin) echo "macos" ;;
        Linux)
            if [[ -f /etc/os-release ]]; then
                . /etc/os-release
                case "$ID" in
                    ubuntu|debian|pop|linuxmint) echo "debian" ;;
                    fedora|rhel|centos|rocky|alma) echo "fedora" ;;
                    arch|manjaro|endeavouros) echo "arch" ;;
                    *) echo "linux-unknown" ;;
                esac
            else
                echo "linux-unknown"
            fi
            ;;
        *) echo "unknown" ;;
    esac
}

OS=$(detect_os)
info "Detected OS: $OS"

# ============================================================================
# Package Installation
# ============================================================================

install_packages_macos() {
    info "Installing packages via Homebrew..."

    # Install Homebrew if not present
    if ! command_exists brew; then
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH for this session
        if [[ -f /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -f /usr/local/bin/brew ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi

    # Install packages
    brew install neovim tmux ripgrep fd fzf atuin zoxide sesh

    success "macOS packages installed"
}

install_packages_debian() {
    info "Installing packages via apt..."
    sudo apt-get update
    sudo apt-get install -y neovim tmux ripgrep fd-find fzf zoxide curl git

    # fd is named fd-find on Debian/Ubuntu, create symlink if needed
    if ! command_exists fd && command_exists fdfind; then
        sudo ln -sf "$(which fdfind)" /usr/local/bin/fd
    fi

    # atuin (not in apt, use installer script)
    if ! command_exists atuin; then
        info "Installing atuin..."
        curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    fi

    # sesh (not in apt, install via go)
    if ! command_exists sesh; then
        if command_exists go; then
            info "Installing sesh via go..."
            go install github.com/joshmedeski/sesh@latest
        else
            warn "sesh requires Go. Install Go first, then run: go install github.com/joshmedeski/sesh@latest"
        fi
    fi

    success "Debian/Ubuntu packages installed"
}

install_packages_fedora() {
    info "Installing packages via dnf..."
    sudo dnf install -y neovim tmux ripgrep fd-find fzf zoxide curl git

    # atuin (not in dnf, use installer script)
    if ! command_exists atuin; then
        info "Installing atuin..."
        curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    fi

    # sesh (not in dnf, install via go)
    if ! command_exists sesh; then
        if command_exists go; then
            info "Installing sesh via go..."
            go install github.com/joshmedeski/sesh@latest
        else
            warn "sesh requires Go. Install Go first, then run: go install github.com/joshmedeski/sesh@latest"
        fi
    fi

    success "Fedora/RHEL packages installed"
}

install_packages_arch() {
    info "Installing packages via pacman..."
    sudo pacman -Syu --noconfirm neovim tmux ripgrep fd fzf zoxide curl git

    # atuin (use installer script for consistency)
    if ! command_exists atuin; then
        info "Installing atuin..."
        curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    fi

    # sesh (install via go)
    if ! command_exists sesh; then
        if command_exists go; then
            info "Installing sesh via go..."
            go install github.com/joshmedeski/sesh@latest
        else
            warn "sesh requires Go. Install Go first, then run: go install github.com/joshmedeski/sesh@latest"
        fi
    fi

    success "Arch packages installed"
}

install_packages() {
    case "$OS" in
        macos) install_packages_macos ;;
        debian) install_packages_debian ;;
        fedora) install_packages_fedora ;;
        arch) install_packages_arch ;;
        *)
            warn "Unknown OS. Please install manually: neovim tmux ripgrep fd fzf atuin zoxide sesh"
            warn "Then re-run this script with --skip-packages"
            ;;
    esac
}

# ============================================================================
# Configuration Linking
# ============================================================================

link_configs() {
    info "Linking configuration files..."

    # Neovim
    mkdir -p "$HOME/.config"
    create_symlink "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"

    # Tmux
    create_symlink "$SCRIPT_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

    # Ghostty
    mkdir -p "$HOME/.config/ghostty"
    create_symlink "$SCRIPT_DIR/ghostty/config" "$HOME/.config/ghostty/config"

    # Zsh - append essential aliases to existing .zshrc
    append_zsh_config

    success "Configuration files linked"
}

# ============================================================================
# Zsh Configuration (append safely to existing .zshrc)
# ============================================================================

append_zsh_config() {
    local zshrc="$HOME/.zshrc"
    local marker="# >>> terminal_config >>>"
    local end_marker="# <<< terminal_config <<<"

    # Remove existing block if present (to update it)
    if grep -q "$marker" "$zshrc" 2>/dev/null; then
        info "Updating existing terminal_config block in .zshrc..."
        # Use sed to remove the old block
        sed -i.bak "/$marker/,/$end_marker/d" "$zshrc"
        rm -f "${zshrc}.bak"
    else
        info "Appending Neovim aliases to .zshrc..."
    fi

    # Append our configuration block
    cat >> "$zshrc" << EOF

$marker
# Added by terminal_config setup
# See: $SCRIPT_DIR/zsh/.zshrc for full reference config

# Neovim as default editor
alias vim='nvim'
alias v='nvim'
export EDITOR='nvim'
export VISUAL='nvim'

# Local overrides (create this file for machine-specific settings)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
$end_marker
EOF

    success "Added Neovim aliases to .zshrc"
    info "Full zsh config available at: $SCRIPT_DIR/zsh/.zshrc"
}

# ============================================================================
# TPM (Tmux Plugin Manager)
# ============================================================================

install_tpm() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"

    if [[ -d "$tpm_dir" ]]; then
        info "TPM already installed, updating..."
        git -C "$tpm_dir" pull --quiet
    else
        info "Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    fi

    success "TPM installed/updated"
    info "Run 'prefix + I' in tmux to install plugins"
}

# ============================================================================
# Cleanup Old Config (optional)
# ============================================================================

cleanup_old_config() {
    info "Cleaning up old configuration..."

    # Remove amix/vimrc if present
    if [[ -d "$HOME/.vim_runtime" ]]; then
        warn "Found old amix/vimrc installation at ~/.vim_runtime"
        read -p "Remove it? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$HOME/.vim_runtime"
            success "Removed ~/.vim_runtime"
        fi
    fi

    # Remove old vim plugin managers
    if [[ -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
        warn "Found old Vundle installation"
        read -p "Remove ~/.vim/bundle? [y/N] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$HOME/.vim/bundle"
            success "Removed ~/.vim/bundle"
        fi
    fi
}

# ============================================================================
# Main
# ============================================================================

show_help() {
    cat << EOF
Usage: $(basename "$0") [OPTIONS]

Terminal configuration installer for macOS and Linux.

OPTIONS:
    --help              Show this help message
    --skip-packages     Skip package installation (assume already installed)
    --cleanup           Clean up old vim/vimrc installations
    --dry-run           Show what would be done without making changes

EXAMPLES:
    ./setup.sh                      # Install packages and link configs
    ./setup.sh --skip-packages      # Only link configs (packages already installed)
    ./setup.sh --cleanup            # Clean up old configs first

WHAT IT DOES:
    - Links nvim/ to ~/.config/nvim
    - Links tmux/.tmux.conf to ~/.tmux.conf
    - Links ghostty/config to ~/.config/ghostty/config
    - Appends Neovim aliases to existing ~/.zshrc (safe, idempotent)
    - Installs TPM (Tmux Plugin Manager)

EOF
}

main() {
    local skip_packages=false
    local dry_run=false
    local cleanup=false

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --help) show_help; exit 0 ;;
            --skip-packages) skip_packages=true ;;
            --cleanup) cleanup=true ;;
            --dry-run) dry_run=true ;;
            *) error "Unknown option: $1" ;;
        esac
        shift
    done

    echo ""
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║           Terminal Configuration Installer                   ║"
    echo "║     Neovim + Tmux + Zsh (optional) for macOS/Linux          ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""

    if [[ "$dry_run" == "true" ]]; then
        warn "DRY RUN - No changes will be made"
        echo ""
    fi

    # Optional cleanup
    if [[ "$cleanup" == "true" ]]; then
        cleanup_old_config
    fi

    # Install packages
    if [[ "$skip_packages" == "false" && "$dry_run" == "false" ]]; then
        install_packages
    elif [[ "$skip_packages" == "true" ]]; then
        info "Skipping package installation (--skip-packages)"
    fi

    # Link configurations
    if [[ "$dry_run" == "false" ]]; then
        link_configs
        install_tpm
    fi

    echo ""
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    Installation Complete!                    ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    info "Next steps:"
    echo "  1. Restart your terminal or run: source ~/.zshrc"
    echo "  2. Open Neovim: nvim (plugins will auto-install)"
    echo "  3. In tmux, press: C-a I (to install tmux plugins)"
    echo ""
    info "Configuration locations:"
    echo "  Neovim:  ~/.config/nvim          -> $SCRIPT_DIR/nvim"
    echo "  Tmux:    ~/.tmux.conf            -> $SCRIPT_DIR/tmux/.tmux.conf"
    echo "  Ghostty: ~/.config/ghostty/config -> $SCRIPT_DIR/ghostty/config"
    echo "  Zsh:     ~/.zshrc                (aliases appended)"
    echo ""
}

main "$@"

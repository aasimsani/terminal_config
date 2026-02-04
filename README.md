# Terminal Configuration

Modern terminal configuration for Neovim, Tmux, and Zsh.

## Features

- **Neovim** with lazy.nvim (fast, lazy-loading plugin manager)
- **Tmux** with modern syntax and vim-tmux-navigator
- **Ghostty** terminal configuration with visual bell, shell integration
- **Zsh** with Oh-My-Zsh and vi-mode
- **Cross-platform** setup script (macOS, Ubuntu/Debian, Fedora, Arch)

## Quick Start

```bash
git clone https://github.com/yourusername/terminal_config.git
cd terminal_config
./setup.sh
```

## Structure

```
terminal_config/
├── setup.sh              # Cross-platform installer
├── nvim/                 # Neovim configuration (symlinked to ~/.config/nvim)
│   ├── init.lua          # Entry point
│   └── lua/
│       ├── config/       # Core settings
│       │   ├── options.lua
│       │   ├── keymaps.lua
│       │   ├── autocmds.lua
│       │   └── lazy.lua
│       └── plugins/      # Plugin specifications
│           ├── navigation.lua
│           ├── git.lua
│           ├── editor.lua
│           ├── ui.lua
│           ├── completion.lua
│           └── treesitter.lua
├── tmux/
│   └── .tmux.conf        # Tmux configuration (symlinked to ~/.tmux.conf)
├── ghostty/
│   └── config            # Ghostty terminal config (symlinked to ~/.config/ghostty/config)
└── zsh/
    └── .zshrc            # Reference Zsh config (Oh-My-Zsh + vi-mode)
```

## Key Bindings

### Neovim

| Key | Action |
|-----|--------|
| `,` | Leader key |
| `<Space>` | Toggle file tree (nvim-tree) |
| `,w` | Save file |
| `,ff` | Find files (Telescope) |
| `,fg` | Live grep (Telescope) |
| `gh/gj/gk/gl` | Navigate between splits |
| `C-h/j/k/l` | Navigate splits (also works with tmux) |
| `ga` | Easy align |
| `gcc` | Comment line |
| `]c` / `[c` | Next/previous git hunk |

### Tmux

| Key | Action |
|-----|--------|
| `C-a` | Prefix (instead of C-b) |
| `C-a \|` | Split vertically |
| `C-a -` | Split horizontally |
| `C-h/j/k/l` | Navigate panes (works with Neovim) |
| `C-a I` | Install plugins (TPM) |
| `C-a r` | Reload config |

## Plugins

### Neovim Plugins

#### Navigation

| Plugin | Basic Usage | Docs |
|--------|-------------|------|
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | `<Space>` toggle, `a` create file, `d` delete, `r` rename, `c` copy, `p` paste | [Wiki](https://github.com/nvim-tree/nvim-tree.lua/wiki) |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | `,ff` files, `,fg` grep, `,fb` buffers, `,fh` help, `C-p` files | [Docs](https://github.com/nvim-telescope/telescope.nvim#default-mappings) |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | `C-h/j/k/l` navigate panes (works across tmux/nvim) | [README](https://github.com/christoomey/vim-tmux-navigator#usage) |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Press leader (`,`) and wait to see available keys | [Docs](https://github.com/folke/which-key.nvim#-usage) |

#### Git

| Plugin | Basic Usage | Docs |
|--------|-------------|------|
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | `,gs` status, `,gb` blame, `,gd` diff, `:Git commit`, `:Git push` | [Docs](https://github.com/tpope/vim-fugitive#fugitivevim) |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | `]c`/`[c` next/prev hunk, `,hs` stage hunk, `,hr` reset hunk, `,hp` preview | [Usage](https://github.com/lewis6991/gitsigns.nvim#usage) |

#### Editor

| Plugin | Basic Usage | Docs |
|--------|-------------|------|
| [vim-easy-align](https://github.com/junegunn/vim-easy-align) | `ga` + motion + char (e.g., `gaip=` align paragraph on `=`) | [Examples](https://github.com/junegunn/vim-easy-align#examples) |
| [Comment.nvim](https://github.com/numToStr/Comment.nvim) | `gcc` comment line, `gc` + motion, `gbc` block comment | [Usage](https://github.com/numToStr/Comment.nvim#-usage) |
| [mini.surround](https://github.com/echasnovski/mini.surround) | `sa` add, `sd` delete, `sr` replace (e.g., `saiw"` surround word with quotes) | [Docs](https://github.com/echasnovski/mini.surround#default-config) |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-closes `()`, `[]`, `{}`, `""`, `''` | [README](https://github.com/windwp/nvim-autopairs) |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Shows indent guides automatically | [Docs](https://github.com/lukas-reineke/indent-blankline.nvim) |

#### Completion & Snippets

| Plugin | Basic Usage | Docs |
|--------|-------------|------|
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | `C-n`/`C-p` navigate, `C-Space` trigger, `CR` confirm, `Tab` next/expand | [Wiki](https://github.com/hrsh7th/nvim-cmp/wiki) |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | `Tab` expand/jump, `S-Tab` jump back | [Docs](https://github.com/L3MON4D3/LuaSnip#keymaps) |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Type snippet prefix + `Tab` (e.g., `fn` for function) | [Snippets List](https://github.com/rafamadriz/friendly-snippets/tree/main/snippets) |

#### UI & Syntax

| Plugin | Basic Usage | Docs |
|--------|-------------|------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Automatic syntax highlighting, `:TSInstall <lang>` for new languages | [Commands](https://github.com/nvim-treesitter/nvim-treesitter#commands) |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline, shows mode/branch/file/position | [Config](https://github.com/nvim-lualine/lualine.nvim#default-configuration) |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme, `:colorscheme tokyonight-night/storm/day/moon` | [Docs](https://github.com/folke/tokyonight.nvim#-configuration) |

#### Plugin Manager

| Plugin | Basic Usage | Docs |
|--------|-------------|------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | `:Lazy` open UI, `:Lazy sync` update all, `:Lazy profile` startup times | [Docs](https://github.com/folke/lazy.nvim#-usage) |

### Tmux Plugins

| Plugin | Basic Usage | Docs |
|--------|-------------|------|
| [TPM](https://github.com/tmux-plugins/tpm) | `C-a I` install plugins, `C-a U` update | [README](https://github.com/tmux-plugins/tpm#key-bindings) |
| [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) | Better defaults (auto) | [Options](https://github.com/tmux-plugins/tmux-sensible#options) |

## Setup Options

```bash
./setup.sh                    # Full install
./setup.sh --skip-packages    # Skip package installation
./setup.sh --cleanup          # Remove old vim configurations
./setup.sh --dry-run          # Preview changes
./setup.sh --help             # Show all options
```

The setup script:
- Links `nvim/` → `~/.config/nvim`
- Links `tmux/.tmux.conf` → `~/.tmux.conf`
- Links `ghostty/config` → `~/.config/ghostty/config`
- **Safely appends** Neovim aliases to existing `~/.zshrc` (idempotent)
- Installs TPM (Tmux Plugin Manager)

### Zsh Configuration

The `zsh/.zshrc` file is a **reference configuration** with:
- Oh-My-Zsh with robbyrussell theme
- Vi-mode with menu navigation (h/j/k/l in completion)
- Plugins: git, python, docker, zsh-vi-mode, zsh-syntax-highlighting, zsh-autosuggestions
- Tool integrations: atuin, zoxide, sesh, conda, nvm, pnpm, uv, gcloud

The setup script appends essential aliases (`vim='nvim'`, `EDITOR='nvim'`) to your existing `.zshrc` rather than replacing it. To use the full reference config, copy it manually:

```bash
cp zsh/.zshrc ~/.zshrc
```

## Requirements

- Neovim 0.9+
- Tmux 3.0+
- Git
- A [Nerd Font](https://www.nerdfonts.com/) for icons

## CLI Tools

The setup script installs these productivity tools:

| Tool | Description | Usage |
|------|-------------|-------|
| [atuin](https://github.com/atuinsh/atuin) | Shell history with sync & search | `Ctrl+R` for fuzzy search |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter cd command | `z <partial-dir>` to jump |
| [sesh](https://github.com/joshmedeski/sesh) | Tmux session manager | `sesh connect <name>` |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder | Used by other tools |

### Installation by Platform

| Tool | macOS | Debian/Ubuntu | Fedora | Arch |
|------|-------|---------------|--------|------|
| atuin | `brew install atuin` | [installer](https://setup.atuin.sh) | [installer](https://setup.atuin.sh) | [installer](https://setup.atuin.sh) |
| zoxide | `brew install zoxide` | `apt install zoxide` | `dnf install zoxide` | `pacman -S zoxide` |
| sesh | `brew install sesh` | `go install github.com/joshmedeski/sesh@latest` | `go install ...` | `go install ...` |
| fzf | `brew install fzf` | `apt install fzf` | `dnf install fzf` | `pacman -S fzf` |

### Post-Install Setup

Add these to the end of your `~/.zshrc` (already included in `zsh/.zshrc`):

```bash
# atuin (shell history)
eval "$(atuin init zsh)"

# zoxide (smarter cd)
eval "$(zoxide init zsh)"

# sesh (tmux session manager)
eval "$(sesh completion zsh)"
```

**atuin**: Run `atuin register` to enable cross-machine sync (optional). Use `Ctrl+R` to search history.

**zoxide**: Use `z <partial-dir>` to jump to frequently used directories.

**sesh**: Use `sesh list` to see sessions, `sesh connect <name>` to connect.

## Performance

Target startup time: **<50ms**

Plugins are lazy-loaded:
- Immediate: statusline, colorscheme, vim-tmux-navigator
- On VeryLazy: gitsigns, which-key
- On InsertEnter: completion, snippets
- On Command: telescope, fugitive
- On Keys: nvim-tree, easy-align

Check startup time:
```bash
nvim --startuptime /tmp/startup.log +q && tail -1 /tmp/startup.log
```

## Customization

### Local Overrides

Create `~/.zshrc.local` for machine-specific settings (not tracked in git).

### Adding Plugins

Add a new file in `nvim/lua/plugins/` or append to an existing one:

```lua
-- nvim/lua/plugins/my-plugins.lua
return {
    { "author/plugin-name", opts = {} },
}
```

## Migration from Old Config

If you have an existing setup with amix/vimrc or Vundle:

```bash
./setup.sh --cleanup
```

This will prompt to remove:
- `~/.vim_runtime` (amix/vimrc)
- `~/.vim/bundle` (Vundle)

-- options.lua - Neovim Options
-- Ported from amix/vimrc basic.vim with modern Neovim equivalents

local opt = vim.opt

-- ============================================================================
-- General
-- ============================================================================
opt.history = 500                    -- Command history
opt.autoread = true                  -- Auto-reload files changed outside
opt.hidden = true                    -- Allow hidden buffers
opt.mouse = "a"                      -- Enable mouse support
opt.clipboard = "unnamedplus"        -- Use system clipboard
opt.updatetime = 250                 -- Faster completion/CursorHold
opt.timeoutlen = 300                 -- Faster key sequence completion

-- ============================================================================
-- UI
-- ============================================================================
opt.number = true                    -- Line numbers
opt.relativenumber = true            -- Relative line numbers
opt.cursorline = true                -- Highlight current line
opt.signcolumn = "yes"               -- Always show sign column
opt.scrolloff = 7                    -- Lines visible above/below cursor
opt.sidescrolloff = 8                -- Columns visible left/right of cursor
opt.termguicolors = true             -- True color support
opt.showmode = false                 -- Don't show mode (statusline handles it)
opt.cmdheight = 1                    -- Command line height
opt.laststatus = 3                   -- Global statusline
opt.splitbelow = true                -- Horizontal splits below
opt.splitright = true                -- Vertical splits right
opt.wrap = false                     -- Don't wrap lines
opt.linebreak = true                 -- Wrap at word boundaries (when wrap on)

-- ============================================================================
-- Search
-- ============================================================================
opt.ignorecase = true                -- Case insensitive search
opt.smartcase = true                 -- Case sensitive if uppercase present
opt.hlsearch = true                  -- Highlight search results
opt.incsearch = true                 -- Incremental search
opt.magic = true                     -- Magic regex mode

-- ============================================================================
-- Tabs & Indentation
-- ============================================================================
opt.expandtab = true                 -- Spaces instead of tabs
opt.smarttab = true                  -- Smart tab behavior
opt.shiftwidth = 4                   -- Indent width
opt.tabstop = 4                      -- Tab width
opt.softtabstop = 4                  -- Soft tab width
opt.autoindent = true                -- Auto indent
opt.smartindent = true               -- Smart indent

-- ============================================================================
-- Files & Backup
-- ============================================================================
opt.backup = false                   -- No backup files
opt.writebackup = false              -- No backup before overwriting
opt.swapfile = false                 -- No swap files
opt.undofile = true                  -- Persistent undo
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.encoding = "utf-8"               -- UTF-8 encoding
opt.fileencoding = "utf-8"           -- File encoding
opt.fileformats = "unix,dos,mac"     -- File format priority

-- ============================================================================
-- Completion
-- ============================================================================
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10                   -- Popup menu height
opt.wildmenu = true                  -- Command completion menu
opt.wildmode = "longest:full,full"   -- Command completion mode
opt.wildignore:append({              -- Ignore patterns
    "*.o", "*~", "*.pyc",
    "*/.git/*", "*/.hg/*", "*/.svn/*",
    "*/.DS_Store", "*/node_modules/*",
})

-- ============================================================================
-- Performance
-- ============================================================================
opt.lazyredraw = true                -- Don't redraw during macros
opt.synmaxcol = 240                  -- Max syntax highlight column

-- ============================================================================
-- Neovim-specific
-- ============================================================================
opt.inccommand = "nosplit"           -- Live substitution preview
opt.fillchars = {
    eob = " ",                       -- Hide ~ at end of buffer
}

-- Create undo directory if it doesn't exist
vim.fn.mkdir(vim.fn.stdpath("data") .. "/undo", "p")

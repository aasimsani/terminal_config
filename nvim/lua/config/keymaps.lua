-- keymaps.lua - Key Mappings
-- Preserved from original .vimrc and amix/vimrc

local map = vim.keymap.set

-- ============================================================================
-- General
-- ============================================================================

-- Fast save
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save all files" })

-- Fast quit
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Clear search highlighting
map("n", "<leader><cr>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Better escape (jk in insert mode)
map("i", "jk", "<esc>", { desc = "Exit insert mode" })

-- ============================================================================
-- Window Navigation (preserved from original: gh, gj, gk, gl)
-- ============================================================================
map("n", "gh", "<C-w>h", { desc = "Go to left window" })
map("n", "gj", "<C-w>j", { desc = "Go to lower window" })
map("n", "gk", "<C-w>k", { desc = "Go to upper window" })
map("n", "gl", "<C-w>l", { desc = "Go to right window" })

-- Also support Ctrl+hjkl (standard, works with vim-tmux-navigator)
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Window resize with arrows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- ============================================================================
-- Buffer Navigation (from amix/vimrc)
-- ============================================================================
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>ba", "<cmd>bufdo bd<cr>", { desc = "Delete all buffers" })
map("n", "<leader>l", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>h", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- ============================================================================
-- Tab Management (from amix/vimrc)
-- ============================================================================
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close other tabs" })
map("n", "<leader>tc", "<cmd>tabclose<cr>", { desc = "Close tab" })
map("n", "<leader>tm", "<cmd>tabmove<cr>", { desc = "Move tab" })
map("n", "<leader>t<leader>", "<cmd>tabnext<cr>", { desc = "Next tab" })

-- ============================================================================
-- Line Movement (move lines up/down with Alt+j/k)
-- ============================================================================
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- ============================================================================
-- Visual Mode Improvements
-- ============================================================================
-- Stay in visual mode when indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Don't yank on paste in visual mode
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- ============================================================================
-- Search & Replace
-- ============================================================================
-- Search for visually selected text
map("v", "//", [[y/\V<C-R>=escape(@",'/\')<CR><CR>]], { desc = "Search selection" })

-- Replace word under cursor
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- ============================================================================
-- Quickfix & Location List
-- ============================================================================
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix" })
map("n", "]l", "<cmd>lnext<cr>", { desc = "Next location" })
map("n", "[l", "<cmd>lprev<cr>", { desc = "Previous location" })

-- ============================================================================
-- Misc
-- ============================================================================
-- Toggle spell checking
map("n", "<leader>ss", "<cmd>setlocal spell!<cr>", { desc = "Toggle spell check" })

-- Toggle paste mode
map("n", "<leader>pp", "<cmd>set paste!<cr>", { desc = "Toggle paste mode" })

-- Source current file
map("n", "<leader>so", "<cmd>source %<cr>", { desc = "Source current file" })

-- Better terminal escape
map("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

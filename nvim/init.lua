-- init.lua - Neovim Configuration Entry Point
-- Optimized for fast startup with lazy.nvim

-- Set leader key early (before lazy.nvim)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Load core configuration
require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")

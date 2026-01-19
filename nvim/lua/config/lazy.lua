-- lazy.lua - lazy.nvim Plugin Manager Bootstrap

-- Bootstrap lazy.nvim (auto-install if not present)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins from lua/plugins/*.lua
require("lazy").setup("plugins", {
    defaults = {
        lazy = true, -- Lazy-load by default for performance
    },
    install = {
        colorscheme = { "default" },
    },
    checker = {
        enabled = false, -- Don't auto-check for updates (manual: :Lazy update)
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

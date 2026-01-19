-- treesitter.lua - Syntax Highlighting

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        opts = {
            ensure_installed = {
                "bash", "c", "css", "dockerfile", "go", "html",
                "javascript", "json", "lua", "luadoc", "markdown",
                "markdown_inline", "python", "regex", "rust", "toml",
                "tsx", "typescript", "vim", "vimdoc", "yaml",
            },
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
        },
        config = function(_, opts)
            -- Try new API first, fall back to old API
            local ok, ts = pcall(require, "nvim-treesitter.configs")
            if ok then
                ts.setup(opts)
            else
                -- New API (nvim-treesitter 1.0+)
                require("nvim-treesitter").setup(opts)
            end
        end,
    },
}

-- ui.lua - UI Plugins
-- lualine, colorscheme, notifications

return {
    -- ========================================================================
    -- Colorscheme
    -- ========================================================================
    {
        "folke/tokyonight.nvim",
        lazy = false, -- Load immediately
        priority = 1000, -- Load before other plugins
        opts = {
            style = "night",
            transparent = false,
            terminal_colors = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
            },
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd.colorscheme("tokyonight")
        end,
    },

    -- ========================================================================
    -- Lualine (statusline)
    -- ========================================================================
    {
        "nvim-lualine/lualine.nvim",
        lazy = false, -- Load immediately for statusline
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                theme = "auto",
                globalstatus = true,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = { "dashboard", "lazy" },
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = {
                    { "filename", path = 1 }, -- Relative path
                },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            extensions = { "nvim-tree", "fugitive", "lazy" },
        },
    },

    -- ========================================================================
    -- Nvim-Web-Devicons (file icons)
    -- ========================================================================
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {
            default = true,
        },
    },

    -- ========================================================================
    -- Noice (better UI for messages, cmdline, popupmenu)
    -- Optional: comment out if you prefer default Neovim UI
    -- ========================================================================
    -- {
    --     "folke/noice.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "rcarriga/nvim-notify",
    --     },
    --     opts = {
    --         lsp = {
    --             override = {
    --                 ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --                 ["vim.lsp.util.stylize_markdown"] = true,
    --                 ["cmp.entry.get_documentation"] = true,
    --             },
    --         },
    --         presets = {
    --             bottom_search = true,
    --             command_palette = true,
    --             long_message_to_split = true,
    --         },
    --     },
    -- },

    -- ========================================================================
    -- Dressing (better vim.ui.select and vim.ui.input)
    -- ========================================================================
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {
            input = {
                enabled = true,
                default_prompt = "Input:",
                border = "rounded",
            },
            select = {
                enabled = true,
                backend = { "telescope", "builtin" },
            },
        },
    },
}

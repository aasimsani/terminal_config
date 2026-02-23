-- editor.lua - Editor Enhancement Plugins
-- vim-easy-align, Comment.nvim, surround, autopairs

return {
    -- ========================================================================
    -- Vim-Easy-Align (text alignment)
    -- ========================================================================
    {
        "junegunn/vim-easy-align",
        keys = {
            { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Easy align" },
        },
    },

    -- ========================================================================
    -- Comment.nvim (commenting)
    -- ========================================================================
    {
        "numToStr/Comment.nvim",
        keys = {
            { "gcc", mode = "n", desc = "Comment line" },
            { "gc", mode = { "n", "v" }, desc = "Comment" },
            { "gb", mode = { "n", "v" }, desc = "Block comment" },
        },
        opts = {},
    },

    -- ========================================================================
    -- Mini.surround (surround text objects)
    -- ========================================================================
    {
        "echasnovski/mini.surround",
        keys = {
            { "sa", mode = { "n", "v" }, desc = "Add surrounding" },
            { "sd", desc = "Delete surrounding" },
            { "sf", desc = "Find surrounding" },
            { "sF", desc = "Find surrounding (left)" },
            { "sh", desc = "Highlight surrounding" },
            { "sr", desc = "Replace surrounding" },
            { "sn", desc = "Update n_lines" },
        },
        opts = {
            mappings = {
                add = "sa",
                delete = "sd",
                find = "sf",
                find_left = "sF",
                highlight = "sh",
                replace = "sr",
                update_n_lines = "sn",
            },
        },
    },

    -- ========================================================================
    -- Autopairs
    -- ========================================================================
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true, -- Use treesitter
            ts_config = {
                lua = { "string", "source" },
                javascript = { "string", "template_string" },
            },
        },
    },

    -- ========================================================================
    -- Indent guides
    -- ========================================================================
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = {
                enabled = true,
                show_start = false,
                show_end = false,
            },
            exclude = {
                filetypes = {
                    "help",
                    "dashboard",
                    "lazy",
                    "mason",
                    "notify",
                    "NvimTree",
                },
            },
        },
    },

    -- ========================================================================
    -- Better text objects
    -- ========================================================================
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        opts = {
            n_lines = 500,
        },
    },

    -- ========================================================================
    -- Render Markdown (pretty markdown rendering)
    -- ========================================================================
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        ft = { "markdown" },
        opts = {},
    },
}

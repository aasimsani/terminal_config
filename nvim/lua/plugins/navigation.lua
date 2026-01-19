-- navigation.lua - Navigation Plugins
-- vim-tmux-navigator, nvim-tree, telescope

return {
    -- ========================================================================
    -- Vim-Tmux Navigator (seamless pane/split navigation)
    -- ========================================================================
    {
        "christoomey/vim-tmux-navigator",
        lazy = false, -- Must load immediately for keybindings
        keys = {
            { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left" },
            { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down" },
            { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up" },
            { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right" },
        },
    },

    -- ========================================================================
    -- Nvim-Tree (file explorer - replaces NERDTree)
    -- ========================================================================
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<Space>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
            { "<leader>e", "<cmd>NvimTreeFocus<cr>", desc = "Focus file tree" },
            { "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in tree" },
        },
        opts = {
            disable_netrw = true,
            hijack_netrw = true,
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = false,
            },
            view = {
                width = 30,
                side = "left",
            },
            renderer = {
                highlight_git = true,
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                },
            },
            filters = {
                dotfiles = false, -- Show hidden files (like NERDTree ShowHidden was set)
                custom = { "^.git$" },
            },
            git = {
                enable = true,
                ignore = false,
            },
            actions = {
                open_file = {
                    quit_on_open = false,
                    resize_window = true,
                },
            },
        },
    },

    -- ========================================================================
    -- Telescope (fuzzy finder - replaces command-t)
    -- ========================================================================
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable("make") == 1
                end,
            },
        },
        cmd = "Telescope",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
            { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
            { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
            { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
        },
        opts = {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "truncate" },
                file_ignore_patterns = {
                    "node_modules",
                    ".git/",
                    "%.pyc",
                    "__pycache__",
                    "%.o",
                },
                mappings = {
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                        ["<esc>"] = "close",
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
            },
        },
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            pcall(telescope.load_extension, "fzf")
        end,
    },

    -- ========================================================================
    -- Which-Key (keybinding hints)
    -- ========================================================================
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            plugins = {
                spelling = { enabled = true },
            },
            win = {
                border = "rounded",
            },
        },
        config = function(_, opts)
            local wk = require("which-key")
            wk.setup(opts)
            wk.add({
                { "<leader>f", group = "Find" },
                { "<leader>g", group = "Git" },
                { "<leader>t", group = "Tabs" },
                { "<leader>b", group = "Buffers" },
            })
        end,
    },
}

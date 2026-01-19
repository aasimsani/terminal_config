-- autocmds.lua - Autocommands

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ============================================================================
-- General
-- ============================================================================

-- Highlight on yank
autocmd("TextYankPost", {
    group = augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

-- Resize splits when window is resized
autocmd("VimResized", {
    group = augroup("resize_splits", { clear = true }),
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- Return to last edit position when opening files
autocmd("BufReadPost", {
    group = augroup("last_position", { clear = true }),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- ============================================================================
-- File Type Settings
-- ============================================================================

-- Remove trailing whitespace on save (for specific filetypes)
autocmd("BufWritePre", {
    group = augroup("trim_whitespace", { clear = true }),
    pattern = { "*.py", "*.lua", "*.js", "*.ts", "*.jsx", "*.tsx", "*.c", "*.cpp", "*.h", "*.rs", "*.go" },
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Set specific options for certain filetypes
autocmd("FileType", {
    group = augroup("filetype_settings", { clear = true }),
    pattern = { "lua", "javascript", "typescript", "json", "yaml", "html", "css" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
    end,
})

-- Enable wrap for text files
autocmd("FileType", {
    group = augroup("wrap_text", { clear = true }),
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Close certain filetypes with 'q'
autocmd("FileType", {
    group = augroup("close_with_q", { clear = true }),
    pattern = { "help", "man", "lspinfo", "qf", "checkhealth", "notify", "startuptime" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
})

-- ============================================================================
-- Auto-create directories on save
-- ============================================================================
autocmd("BufWritePre", {
    group = augroup("auto_create_dir", { clear = true }),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- ============================================================================
-- Terminal
-- ============================================================================
autocmd("TermOpen", {
    group = augroup("terminal_settings", { clear = true }),
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.cmd("startinsert")
    end,
})

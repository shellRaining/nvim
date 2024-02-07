local map = require("utils.map")

local M = {}

-- basic set
map.bulk_register({
    {
        mode = { "n" },
        lhs = "<leader><esc>",
        rhs = "<cmd>qa!<cr>",
        options = { silent = true },
        description = "Escape Neovim",
    },
    {
        mode = { "n", "v" },
        lhs = "<c-u>",
        rhs = function()
            vim.cmd("normal! " .. math.ceil(vim.api.nvim_win_get_height(0) / 4) .. "k")
        end,
        options = { silent = true },
        description = "Move 1/4 screen up",
    },
    {
        mode = { "n", "v" },
        lhs = "<c-0>",
        rhs = "^",
        options = { silent = true },
        description = "Move to first non-blank character of line",
    },
    {
        mode = { "n", "v" },
        lhs = "<c-d>",
        rhs = function()
            vim.cmd("normal! " .. math.ceil(vim.api.nvim_win_get_height(0) / 4) .. "j")
        end,
        options = { silent = true },
        description = "Move 1/4 screen down",
    },
    {
        mode = { "n", "x" },
        lhs = "k",
        rhs = function()
            return vim.v.count > 0 and "k" or "gk"
        end,
        options = { silent = true, expr = true },
        description = "Move up one line",
    },
    {
        mode = { "n", "x" },
        lhs = "j",
        rhs = function()
            return vim.v.count > 0 and "j" or "gj"
        end,
        options = { silent = true, expr = true },
        description = "Move down one line",
    },
    {
        mode = { "v" },
        lhs = "<",
        rhs = "<gv",
        options = { noremap = true },
        description = "move the select_hunk to left",
    },
    {
        mode = { "v" },
        lhs = ">",
        rhs = ">gv",
        options = { noremap = true },
        description = "move the select_hunk to right",
    },
    {
        mode = { "n" },
        lhs = "*",
        rhs = "*N",
        options = { noremap = true },
        description = "search the word under cursor forward",
    },
    {
        mode = { "i", "n" },
        lhs = "<esc>",
        rhs = "<cmd>noh<cr><esc>",
        options = { silent = true, noremap = true },
        description = "stop highlight search when escape insert mode",
    },
})

-- console mapping
map.bulk_register({
    {
        mode = { "c" },
        lhs = "<m-p>",
        rhs = "<up>",
        options = {},
        description = "Look up history",
    },
    {
        mode = { "c" },
        lhs = "<m-n>",
        rhs = "<down>",
        options = {},
        description = "Look down history",
    },
    {
        mode = { "t" },
        lhs = "<esc>",
        rhs = "<c-\\><c-n>",
        options = { silent = true },
        description = "Escape terminal insert mode",
    },
    {
        mode = { "t" },
        lhs = "<c-q>",
        rhs = "<c-\\><c-n><cmd>BufferDelete<cr>",
        options = { silent = true },
        description = "Escape terminal",
    },
    {
        mode = { "t" },
        lhs = "<c-h>",
        rhs = "<cmd>wincmd h<cr>",
        options = { silent = true },
        description = "goto left window",
    },
    {
        mode = { "t" },
        lhs = "<c-j>",
        rhs = "<cmd>wincmd j<cr>",
        options = { silent = true },
        description = "goto lower window",
    },
    {
        mode = { "t" },
        lhs = "<c-k>",
        rhs = "<cmd>wincmd k<cr>",
        options = { silent = true },
        description = "goto upper window",
    },
    {
        mode = { "t" },
        lhs = "<c-l>",
        rhs = "<cmd>wincmd l<cr>",
        options = { silent = true },
        description = "goto right window",
    },
})

-- windows mapping
map.bulk_register({
    {
        mode = { "n" },
        lhs = "<m-k>",
        rhs = "<c-w>-",
        options = { silent = true },
        description = "Reduce horizontal split screen size",
    },
    {
        mode = { "n" },
        lhs = "<m-j>",
        rhs = "<c-w>+",
        options = { silent = true },
        description = "Increase horizontal split screen size",
    },
    {
        mode = { "n" },
        lhs = "<m-h>",
        rhs = "<c-w><",
        options = { silent = true },
        description = "Reduce vertical split screen size",
    },
    {
        mode = { "n" },
        lhs = "<m-l>",
        rhs = "<c-w>>",
        options = { silent = true },
        description = "Increase vertical split screen size",
    },
    {
        mode = { "n" },
        lhs = "<c-l>",
        rhs = "<c-w>l",
        options = { silent = true },
        description = "goto right window",
    },
    {
        mode = { "n" },
        lhs = "<c-h>",
        rhs = "<c-w>h",
        options = { silent = true },
        description = "goto left window",
    },
    {
        mode = { "n" },
        lhs = "<c-j>",
        rhs = "<c-w>j",
        options = { silent = true },
        description = "goto lower window",
    },
    {
        mode = { "n" },
        lhs = "<c-k>",
        rhs = "<c-w>k",
        options = { silent = true },
        description = "goto upper window",
    },
})

-- insert mapping
map.bulk_register({
    {
        mode = { "i", "c", "t" },
        lhs = "<m-w>",
        rhs = "<c-right>",
        options = {},
        description = "Jump to next word in insert mode",
    },
    {
        mode = { "i", "c", "t" },
        lhs = "<m-e>",
        rhs = "<c-right><left>",
        options = {},
        description = "Jump to end of word in insert mode",
    },
    {
        mode = { "i", "c", "t" },
        lhs = "<m-b>",
        rhs = "<c-left>",
        options = {},
        description = "Jump to previous word in insert mode",
    },
    {
        mode = { "i", "c", "t" },
        lhs = "<m-k>",
        rhs = "<up><c-f>",
        options = {},
        description = "Move cursor up in insert mode",
    },
    {
        mode = { "i", "c", "t" },
        lhs = "<m-j>",
        rhs = "<down><c-f>",
        options = {},
        description = "Move cursor down in insert mode",
    },
    {
        mode = { "i", "c", "t" },
        lhs = "<m-h>",
        rhs = "<left>",
        options = {},
        description = "Move cursor left in insert mode",
    },
    {
        mode = { "i", "c", "t" },
        lhs = "<m-l>",
        rhs = "<right>",
        options = {},
        description = "Move cursor right in insert mode",
    },
    {
        mode = { "i" },
        lhs = "<m-left>",
        rhs = "<c-o>v<c-g>",
        options = { silent = true },
        description = "Select previous word in insert mode",
    },
    {
        mode = { "s" },
        lhs = "<m-left>",
        rhs = "<c-g>h<c-g>",
        options = { silent = true },
        description = "Select previous word in insert mode",
    },
})

-- special
map.bulk_register({
    {
        mode = { "n" },
        lhs = "<leader>cf",
        rhs = function()
            vim.lsp.buf.format({ async = false })
        end,
        options = { silent = true },
        description = "Format buffer",
    },
    {
        mode = { "n" },
        lhs = "<leader>hpb",
        rhs = function()
            require("plenary.profile").start("profile.log", { flame = true })
        end,
        options = { silent = true },
        description = "Start profile",
    },
    {
        mode = { "n" },
        lhs = "<leader>hpe",
        rhs = function()
            require("plenary.profile").stop()
        end,
        options = { silent = true },
        description = "stop profile",
    },
})

return M

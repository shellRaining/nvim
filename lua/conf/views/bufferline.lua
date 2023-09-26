local map = require("utils.map")
local icons = require("utils.public.init").get_icons_group("diagnostic", true)

local M = {
    requires = { "bufferline" },
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.bufferline.setup({
        options = {
            close_command = function(n)
                require("mini.bufremove").delete(n, false)
            end,
            right_mouse_command = function(n)
                require("mini.bufremove").delete(n, false)
            end,
            diagnostics = false,
            always_show_bufferline = false,
            diagnostics_indicator = function(_, _, diag)
                -- local ret = (diag.error and icons.Error .. diag.error .. " " or "")
                --     .. (diag.warning and icons.Warn .. diag.warning or "")
                -- return vim.trim(ret)
            end,
            numbers = "ordinal",
            custom_filter = function(buf_number)
                if vim.bo[buf_number].filetype ~= "qf" then
                    return true
                end
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    highlight = "Directory",
                    text_align = "left",
                },
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    text_align = "center",
                },
                {
                    filetype = "aerial",
                    text = "Outline Explorer",
                    highlight = "Directory",
                    text_align = "center",
                },
                {
                    filetype = "undotree",
                    text = "Undo Explorer",
                    highlight = "Directory",
                    text_align = "center",
                },
                {
                    filetype = "spectre_panel",
                    text = "Project Blurry Search",
                    highlight = "Directory",
                    text_align = "center",
                },
            },
        },
    })
end

function M.after() end

function M.register_key()
    map.bulk_register({
        {
            mode = { "n" },
            lhs = "<c-q>",
            rhs = "<cmd>BufferDelete<cr>",
            options = { silent = true },
            description = "Close current buffer",
        },
        {
            mode = { "n" },
            lhs = "<s-h>",
            rhs = "<cmd>BufferLineCyclePrev<cr>",
            options = { silent = true },
            description = "Go to left buffer",
        },
        {
            mode = { "n" },
            lhs = "<s-l>",
            rhs = "<cmd>BufferLineCycleNext<cr>",
            options = { silent = true },
            description = "Go to right buffer",
        },
        {
            mode = { "n" },
            lhs = "<c-e>",
            rhs = "<cmd>BufferLineMovePrev<cr>",
            options = { silent = true },
            description = "Move current buffer to left",
        },
        {
            mode = { "n" },
            lhs = "<c-y>",
            rhs = "<cmd>BufferLineMoveNext<cr>",
            options = { silent = true },
            description = "Move current buffer to right",
        },
        {
            mode = { "n" },
            lhs = "<leader>1",
            rhs = "<cmd>BufferLineGoToBuffer 1<cr>",
            options = { silent = true },
            description = "Go to buffer 1",
        },
        {
            mode = { "n" },
            lhs = "<leader>2",
            rhs = "<cmd>BufferLineGoToBuffer 2<cr>",
            options = { silent = true },
            description = "Go to buffer 2",
        },
        {
            mode = { "n" },
            lhs = "<leader>3",
            rhs = "<cmd>BufferLineGoToBuffer 3<cr>",
            options = { silent = true },
            description = "Go to buffer 3",
        },
        {
            mode = { "n" },
            lhs = "<leader>4",
            rhs = "<cmd>BufferLineGoToBuffer 4<cr>",
            options = { silent = true },
            description = "Go to buffer 4",
        },
        {
            mode = { "n" },
            lhs = "<leader>5",
            rhs = "<cmd>BufferLineGoToBuffer 5<cr>",
            options = { silent = true },
            description = "Go to buffer 5",
        },
        {
            mode = { "n" },
            lhs = "<leader>6",
            rhs = "<cmd>BufferLineGoToBuffer 6<cr>",
            options = { silent = true },
            description = "Go to buffer 6",
        },
        {
            mode = { "n" },
            lhs = "<leader>7",
            rhs = "<cmd>BufferLineGoToBuffer 7<cr>",
            options = { silent = true },
            description = "Go to buffer 7",
        },
        {
            mode = { "n" },
            lhs = "<leader>8",
            rhs = "<cmd>BufferLineGoToBuffer 8<cr>",
            options = { silent = true },
            description = "Go to buffer 8",
        },
        {
            mode = { "n" },
            lhs = "<leader>9",
            rhs = "<cmd>BufferLineGoToBuffer 9<cr>",
            options = { silent = true },
            description = "Go to buffer 9",
        },
    })
end

return M

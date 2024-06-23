local options = require("core.options")
local api = vim.api

-- auto save buffer
if options.auto_save then
    api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
        pattern = { "*" },
        callback = function()
            if vim.bo.ft == "harpoon" then
                return
            end
            vim.cmd("silent! wall")
        end,
        nested = true,
    })
end

-- auto restore cursor position
if options.auto_restore_cursor_position then
    api.nvim_create_autocmd("BufReadPost", {
        pattern = { "*" },
        callback = function()
            if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
                ---@diagnostic disable-next-line: param-type-mismatch
                vim.fn.setpos(".", vim.fn.getpos("'\""))
                vim.cmd("silent! foldopen")
            end
        end,
    })
end

-- remove auto-comments
if options.auto_remove_new_lines_comment then
    api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = { "*" },
        callback = function()
            vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
        end,
    })
end

-- Highlight on yank
if options.auto_hl_on_yank then
    api.nvim_create_autocmd("TextYankPost", {
        callback = function()
            vim.highlight.on_yank()
        end,
    })
end

-- resize splits if window got resized
if options.auto_resize_window then
    vim.api.nvim_create_autocmd({ "VimResized" }, {
        callback = function()
            local current_tab = vim.fn.tabpagenr()
            vim.cmd("tabdo wincmd =")
            vim.cmd("tabnext " .. current_tab)
        end,
    })
end

-- close some filetypes with <q>
if options.auto_set_quit_map then
    api.nvim_create_autocmd("TermOpen", {
        pattern = { "*" },
        callback = function()
            local bufnr = api.nvim_get_current_buf()
            api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>BufferDelete<cr><c-w>l", {
                silent = true,
                noremap = true,
            })
        end,
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = {
            "zsh",
            "toggleterm",
            "better_term",
            "PlenaryTestPopup",
            "help",
            "lspinfo",
            "man",
            "notify",
            "qf",
            "spectre_panel",
            "startuptime",
            "tsplayground",
            "neotest-output",
            "checkhealth",
            "neotest-summary",
            "neotest-output-panel",
        },
        callback = function(event)
            vim.bo[event.buf].buflisted = false
            vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        end,
    })
end

if options.auto_spell_check_text then
    -- wrap and check for spell in text filetypes
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "gitcommit", "markdown" },
        callback = function()
            vim.opt_local.spellfile = options.spell_config_directory .. "/en.utf-8.add"
            vim.opt_local.wrap = true
            vim.opt_local.spell = true
        end,
    })
end

if options.auto_reload_changed_file then
    vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
        pattern = { "*" },
        callback = function()
            pcall(vim.cmd, "checktime")
        end,
    })
end

if options.auto_switch_relative_number then
    vim.api.nvim_create_autocmd({
        "InsertEnter",
        "InsertLeave",
        "BufEnter",
        "BufLeave",
        "WinEnter",
        "WinLeave",
        "CmdlineEnter",
        "CmdlineLeave",
        "VimEnter",
        "VimLeave",
        "ModeChanged",
    }, {
        callback = function()
            local mode = vim.api.nvim_get_mode().mode
            if mode == "i" or mode == "ic" then
                vim.opt_local.relativenumber = false
            else
                vim.opt_local.relativenumber = true
            end
        end,
    })
end

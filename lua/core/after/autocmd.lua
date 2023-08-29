local options = require("core.options")

-- auto save buffer
if options.auto_save then
    vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
        pattern = { "*" },
        command = "silent! wall",
        nested = true,
    })
end

-- auto restore cursor position
if options.auto_restore_cursor_position then
    vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = { "*" },
        callback = function()
            if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
                vim.fn.setpos(".", vim.fn.getpos("'\""))
                vim.cmd("silent! foldopen")
            end
        end,
    })
end

-- remove auto-comments
if options.auto_remove_new_lines_comment then
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = { "*" },
        callback = function()
            vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
        end,
    })
end

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = { "*" },
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>BufferDelete<cr><c-w>l", {
            silent = true,
            noremap = true,
        })
    end,
})

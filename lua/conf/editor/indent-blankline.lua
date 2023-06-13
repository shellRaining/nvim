-- https://github.com/lukas-reineke/indent-blankline.nvim

local M = {
    requires = {
        "indent_blankline",
    },
}

function M.before()
    vim.g.indent_blankline_filetype_exclude = {
        "help",
        "undotree",
    }
end

function M.load()
    M.indent_blankline.setup({
        show_current_context = true,
        space_char_blankline = "⋅",
    })
end

function M.after() end

return M

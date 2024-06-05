local M = {
    requires = {
        "lualine",
    },
}

function M.load()
    vim.cmd.colorscheme("night-owl")
    M.lualine.setup({
        options = {
            theme = "night-owl",
        },
    })
end

return M

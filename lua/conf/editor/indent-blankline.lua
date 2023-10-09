-- https://github.com/lukas-reineke/indent-blankline.nvim

local M = {
    requires = {
        "ibl",
    },
}

function M.load()
    M.ibl.setup({
        exclude = {
            filetypes = {
                "help",
                "markdown",
                "vimwiki",
                "alpha",
                "dashboard",
            },
        }
    })
end

function M.after() end

return M

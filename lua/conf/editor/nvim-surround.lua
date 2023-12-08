local M = {
    requires = {
        "nvim-surround",
    },
}

function M.load()
    M.nvim_surround.setup({})
end

function M.after() end

return M

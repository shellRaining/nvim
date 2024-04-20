local M = {
    requires = {
        "ranger-nvim",
    },
}

-- stylua: ignore
M.keys = {
    { "<leader>ef", function() M.ranger_nvim.open(true) end, desc = "open ranger" },
}

function M.load()
    M.ranger_nvim.setup({
        replace_netrw = true,
    })
end

return M

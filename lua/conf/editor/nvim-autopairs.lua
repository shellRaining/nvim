local M = {
    requires = {
        "nvim-autopairs",
    },
    event = "VeryLazy",
}

function M.load()
    M.nvim_autopairs.setup({
        map_c_h = true,
        map_c_w = true,
    })
end

return M

local M = {
    requires = { "evergarden" },
}

local config = vim.g.neovide and {
    transparent_background = false,
    style = {
        tabline = { reverse = true, color = "green" },
        search = { reverse = false, inc_reverse = true },
        types = { italic = true },
        keyword = { italic = true },
        comment = { italic = true },
    },
} or {
    transparent_background = true,
    style = {
        tabline = { reverse = true, color = "green" },
        search = { reverse = false, inc_reverse = true },
        types = { italic = true },
        keyword = { italic = true },
        comment = { italic = true },
    },
}

function M.load()
    M.evergarden.setup(config)
    vim.cmd([[colorscheme evergarden]])
end

return M

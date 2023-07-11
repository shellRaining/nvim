local M = {
    requires = {
        "nvim-web-devicons",
    },
}

function M.before() end

function M.load()
    M.nvim_web_devicons.setup()
end

return M

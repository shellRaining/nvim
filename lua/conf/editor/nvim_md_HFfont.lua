local M = {
    requires = {
        "nvim_md_HFfont",
    },
}

function M.before() end

function M.load()
    M.nvim_md_hffont.setup()
end

return M

local M = {
    requires = {
        "yazi",
    },
}

M.keys = {
    {
        "<leader>-",
        function()
            M.yazi.yazi()
        end,
        desc = "Open the file manager",
    },
}

function M.load()
    M.yazi.setup({
        open_for_directories = false,
    })
end

return M

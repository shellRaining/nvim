local M = {
    requires = { "mini.bufremove" },
}

-- stylua: ignore
M.keys = {
    { "<leader>bd", function() M.mini_bufremove.delete(0, false) end, desc = "Delete Buffer", },
    { "<leader>bD", function() M.mini_bufremove.delete(0, true) end, desc = "Delete Buffer (Force)", },
}

function M.load() end

return M

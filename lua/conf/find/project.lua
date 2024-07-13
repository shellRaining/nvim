local M = {
    requires = {
        "project_nvim",
        -- "telescope",
    },
}

function M.load()
    -- M.telescope.load_extension("projects")
    M.project_nvim.setup()
end

return M

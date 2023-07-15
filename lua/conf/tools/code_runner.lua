local api = require("utils.api")

local M = {
    requires = {
        "code_runner",
    },
}

function M.before() end

function M.load()
    M.code_runner.setup({
        filetype = {
            typescript = "deno run",
        },
    })
end

function M.after()
    M.register_key()
end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>rf",
            rhs = "<cmd>RunFile<CR>",
            options = { silent = true },
            description = "run the current project of file",
        },
        {
            mode = { "n" },
            lhs = "<leader>rc",
            rhs = "<cmd>RunCode<CR>",
            options = { silent = true },
            description = "run the current project of file",
        },
        {
            mode = { "n" },
            lhs = "<leader>rp",
            rhs = "<cmd>RunProject<CR>",
            options = { silent = true },
            description = "Find todo tag in the current workspace",
        },
    })
end

return M

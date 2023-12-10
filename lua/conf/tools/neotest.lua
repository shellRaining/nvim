local map = require("utils.map")

local M = {
    requires = {
        "neotest",
        -- "neotest-vitest",
        -- "neotest-jest",
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.neotest.setup({
        adapters = {
            -- M.neotest_vitest,
            -- M.neotest_jest({
            --     jestCommand = "npm test --",
            --     jestConfigFile = "custom.jest.config.ts",
            --     jest_test_discovery = true,
            --     env = { CI = true },
            --     cwd = function(path)
            --         return vim.fn.getcwd()
            --     end,
            -- }),
        },
    })
end

function M.register_key()
    -- map.bulk_register({
    --     {
    --         mode = { "n" },
    --         lhs = "<leader>tw",
    --         rhs = M.neotest.run.run({ jestCommand = "jest --watch " }),
    --         options = { silent = true },
    --         description = "move block down",
    --     },
    -- })
end

return M

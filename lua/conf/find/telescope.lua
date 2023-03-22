-- https://github.com/nvim-telescope/telescope.nvim

local api = require("utils.api")

local M = {
    requires = {
        "telescope",
        "telescope.actions"
    },
}

function M.before()
    M.register_key()
end

function M.load()
    M.telescope.setup({
        defaults = {
            file_ignore_patterns = { "node_modules" },
            -- theme
            layout_strategy = "bottom_pane",
            -- config
            layout_config = {
                bottom_pane = {
                    height = 15,
                    preview_cutoff = 100,
                    prompt_position = "bottom",
                },
            },
            mappings = {
                i = {
                    ["<C-j>"] = M.telescope_actions.cycle_history_next,
                    ["<C-k>"] = M.telescope_actions.cycle_history_prev,
                },
            },
        },
        pickers = {
            buffers = {
                mappings = {
                    i = {
                        ["<c-d>"] = "delete_buffer",
                    },
                    n = {
                        ["dd"] = "delete_buffer",
                    },
                },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            projects = {},
        },
    })
end

function M.after()
    M.telescope.load_extension("fzf")

    -- FIX: https://github.com/nvim-telescope/telescope.nvim/issues/699
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
        pattern = { "*" },
        command = "normal zx",
    })
end

function M.register_key()
    api.map.bulk_register({
        {
            mode = { "n" },
            lhs = "<leader>ff",
            rhs = "<cmd>Telescope find_files<cr>",
            options = { silent = true },
            description = "use telescope to find files",
        },
        {
            mode = { "n" },
            lhs = "<leader>fg",
            rhs = "<cmd>Telescope live_grep<cr>",
            options = { silent = true },
            description = "use telescope to search string pattern",
        },
        {
            mode = { "n" },
            lhs = "<leader>fb",
            rhs = "<cmd>Telescope buffers<cr>",
            options = { silent = true },
            description = "use telescope to find buffers",
        },
        {
            mode = { "n" },
            lhs = "<leader>fh",
            rhs = "<cmd>Telescope help_tags<cr>",
            options = { silent = true },
            description = "use telescope to find help tags",
        },
        {
            mode = { "n" },
            lhs = "<leader>fo",
            rhs = "<cmd>Telescope oldfiles<cr>",
            options = { silent = true },
            description = "use telescope to find oldfiles",
        },
        {
            mode = { "n" },
            lhs = "<leader>f;",
            rhs = "<cmd>Telescope command_history<cr>",
            options = { silent = true },
            description = "use telescope to find history command",
        },
        {
            mode = { "n" },
            lhs = "<leader>f/",
            rhs = "<cmd>Telescope search_history<cr>",
            options = { silent = true },
            description = "use telescope to find search_history",
        },
        {
            mode = { "n" },
            lhs = "<leader>fl",
            rhs = "<cmd>Telescope zoxide list theme=dropdown<cr>",
            options = { silent = true },
            description = "use telescope to find dir use zoxide and enter it",
        },
        {
            mode = { "n" },
            lhs = "<leader>fd",
            rhs = function()
                require("telescope").extensions["todo-comments"].todo()
            end,
            options = { silent = true },
            description = "use telescope to find comments",
        },
    })
end

return M

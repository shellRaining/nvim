local util = require("utils.telescope")

local M = {
    requires = {
        "telescope",
        "telescope.actions",
        "trouble.sources.telescope",
    },
    cmd = "Telescope",
    keys = {
        { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader>/", util.telescope("live_grep"), desc = "Grep (root dir)" },
        { "<leader>;", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
        -- find
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>ff", util.telescope("files"), desc = "Find Files (root dir)" },
        -- { "<leader>ff", "<cmd>Telescope files<cr>", desc = "Find Files (root dir)" },
        { "<leader>fF", util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
        { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
        { "<leader>fO", util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
        -- git
        { "<leader>fg", "<cmd>Telescope git_commits<CR>", desc = "commits" },
        -- search
        { '<leader>fr"', "<cmd>Telescope registers<cr>", desc = "Registers" },
        { "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        { "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        { "<leader>us", util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
        {
            "<leader>fS",
            util.telescope("lsp_document_symbols", {
                symbols = {
                    "Class",
                    "Function",
                    "Method",
                    "Constructor",
                    "Interface",
                    "Module",
                    "Struct",
                    "Trait",
                    "Field",
                    "Property",
                },
            }),
            desc = "Goto Symbol",
        },
        {
            "<leader>fs",
            util.telescope("lsp_dynamic_workspace_symbols", {
                symbols = {
                    "Class",
                    "Function",
                    "Method",
                    "Constructor",
                    "Interface",
                    "Module",
                    "Struct",
                    "Trait",
                    "Field",
                    "Property",
                },
            }),
            desc = "Goto Symbol (Workspace)",
        },
        { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
}

function M.load()
    M.telescope.setup({
        defaults = {
            file_ignore_patterns = { "node_modules" },
            prompt_prefix = " ",
            selection_caret = " ",
            mappings = {
                i = {
                    ["<C-j>"] = M.telescope_actions.cycle_history_next,
                    ["<C-k>"] = M.telescope_actions.cycle_history_prev,
                    ["<c-t>"] = M.trouble_sources_telescope.open,
                },
                n = {
                    ["q"] = M.telescope_actions.close,
                    ["<c-t>"] = M.trouble_sources_telescope.open,
                },
            },
        },
        pickers = {
            buffers = {
                previewer = false,
                theme = "dropdown",
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
            projects = {},
        },
    })
end

return M

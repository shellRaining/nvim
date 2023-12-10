local path = require("utils.path")

local M = {
    requires = {
        "neo-tree",
        "neo-tree.command",
    },
    cmd = "Neotree",
}

function M.load()
    vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
            if package.loaded["neo-tree.sources.git_status"] then
                require("neo-tree.sources.git_status").refresh()
            end
        end,
    })
    M.neo_tree.setup({
        sources = { "filesystem", "buffers", "git_status", "document_symbols" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
        filesystem = {
            bind_to_cwd = false,
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
        },
        window = {
            mappings = {
                ["<space>"] = "none",
            },
        },
        default_component_configs = {
            indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
        },
    })
end

-- stylua: ignore
M.keys = {
    { "<leader>e", function() M.neo_tree_command.execute({ toggle = true, dir = path.get_root() }) end, desc = "Open File Explorer" },
    { "<leader>u1", function() M.neo_tree_command.execute({ toggle = true, dir = vim.loop.cwd() }) end, desc = "Open File Explorer" },
}

return M

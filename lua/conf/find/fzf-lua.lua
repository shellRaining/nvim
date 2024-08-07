local M = {
    requires = {
        "fzf-lua",
    },
    cmd = "FzfLua",
    keys = {
        { "<leader>/", "<cmd>FzfLua live_grep_glob<cr>", desc = "live grep with rg iglob" },
        { "<leader>;", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
        { "<leader>*", "<cmd>FzfLua grep_cword<cr>", desc = "Command History" },
        { "<leader><space>", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
        { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files" },
        { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
        { "<leader>fg", "<cmd>FzfLua git_commits<CR>", desc = "commits" },
        { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
        { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
        { "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "lsp document symbols" },
        { "<leader>us", "<cmd>FzfLua colorschemes<cr>", desc = "Colorscheme with preview" },
    },
}

function M.load()
    local actions = require("trouble.sources.fzf").actions
    M.fzf_lua.setup({
        winopts = {
            height = 0.5,
            width = 0.80,
        },
        actions = {
            files = {
                true,
                ["ctrl-q"] = M.fzf_lua.actions.file_sel_to_qf,
                ["ctrl-t"] = actions.open,
            },
        },
    })

    vim.keymap.set("n", "*", function()
        local cword = vim.fn.expand("<cword>")
        M.fzf_lua.grep_curbuf({ query = cword })
    end)
end

return M

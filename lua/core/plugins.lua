-- https://github.com/folke/lazy.nvim

local aid_lazy = require("utils.aid.lazy")

local M = {}

M.theme = { { "folke/tokyonight.nvim" } }

M.basic = {
    { "folke/noice.nvim" },
    { "williamboman/mason.nvim" },
    { "rcarriga/nvim-notify" },
    { "nvim-tree/nvim-web-devicons", lazy = true },
    { "MunifTanjim/nui.nvim", lazy = true },
    { "nvim-lua/plenary.nvim", lazy = true },
}

M.lsp = {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "folke/neodev.nvim", lazy = true },
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/cmp-nvim-lsp" },
        },
    },
    { "simrat39/rust-tools.nvim", ft = { "rust" }, lazy = true },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "glepnir/lspsaga.nvim" },
    { "SmiteshP/nvim-navic", lazy = true },
}

M.complete = {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-cmdline" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "saadparwaiz1/cmp_luasnip" },
        },
    },
    { "L3MON4D3/LuaSnip" },
    { "zbirenbaum/copilot.lua" },
}

M.find = {
    { "folke/todo-comments.nvim" },
    { "folke/flash.nvim" },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", lazy = true },
            {
                "ahmedkhalf/project.nvim",
                opts = {},
                event = "VeryLazy",
                config = function(_, opts)
                    require("project_nvim").setup(opts)
                    require("telescope").load_extension("projects")
                end,
                keys = {
                    { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
                },
            },
        },
    },
}

M.language = {
    { "davidgranstrom/nvim-markdown-preview", ft = { "markdown" } },
}

M.tools = {
    { "lewis6991/gitsigns.nvim" },
    { "folke/which-key.nvim" },
    { "CRAG666/code_runner.nvim" },
}

M.views = {
    { "nvimdev/dashboard-nvim" },
    { "akinsho/toggleterm.nvim" },
    { "akinsho/bufferline.nvim", event = { "VeryLazy" } },
    { "nvim-lualine/lualine.nvim" },
    { "stevearc/aerial.nvim" },
    { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x" },
    { "folke/trouble.nvim" },
}

M.editor = {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "RRethy/vim-illuminate" },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        event = { "VeryLazy" },
    },
    { "echasnovski/mini.comment", name = "miniComment" },
    { "echasnovski/mini.pairs", name = "miniPairs" },
    { "echasnovski/mini.bufremove", name = "miniBufremove" },
    { "shellRaining/hlchunk.nvim" },
    { "shellRaining/nvim_md_HFfont", ft = { "markdown" } },
    -- {
    --     "echasnovski/mini.indentscope",
    --     event = { "UIEnter" },
    --     config = function()
    --         require("mini.indentscope").setup()
    --     end,
    -- },
    -- {
    --     "nvimdev/indentmini.nvim",
    --     event = "BufEnter",
    --     config = function()
    --         require("indentmini").setup({
    --             {
    --                 char = "|",
    --                 exclude = {
    --                     "erlang",
    --                     "markdown",
    --                 },
    --             },
    --         })
    --         vim.cmd.highlight("default link IndentLine Comment")
    --     end,
    -- },
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     event = { "UIEnter" },
    -- },
}

aid_lazy.entry(M)

return M

-- https://github.com/folke/lazy.nvim

local aid_lazy = require("utils.aid.lazy")

local M = {}

M.theme = {
    { "folke/tokyonight.nvim" },
}

M.basic = {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
    },
    { "nvim-tree/nvim-web-devicons" },
    { "rcarriga/nvim-notify" },
    {
        "williamboman/mason.nvim",
        event = { "VimEnter" },
    },
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
}

M.lsp = {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason-lspconfig.nvim" },
        },
    },
    { "simrat39/rust-tools.nvim" },
    {
        "folke/neodev.nvim",
        lazy = true,
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = { "UIEnter" },
    },
    { "glepnir/lspsaga.nvim" },
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
        event = { "InsertEnter", "CmdlineEnter" },
    },
    {
        "L3MON4D3/LuaSnip",
        lazy = true,
    },
    { "zbirenbaum/copilot.lua" },
}

M.find = {
    {
        "folke/todo-comments.nvim",
    },
    {
        "phaazon/hop.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
    },
}

M.language = {
    {
        "davidgranstrom/nvim-markdown-preview",
        ft = { "markdown" },
    },
}

M.tools = {
    {
        "NvChad/nvim-colorizer.lua",
        event = { "UIEnter" },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "UIEnter" },
    },
    {
        "folke/which-key.nvim",
        event = { "VeryLazy" },
    },
    {
        "CRAG666/code_runner.nvim",
        event = { "VeryLazy" },
    },
}

M.views = {
    { "nvimdev/dashboard-nvim" },
    -- { 'CRAG666/betterTerm.nvim' },
    { "akinsho/toggleterm.nvim" },
    {
        "akinsho/bufferline.nvim",
        event = { "UIEnter" },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = { "UIEnter" },
    },
    {
        "mbbill/undotree",
        event = { "UIEnter" },
    },
    {
        "stevearc/aerial.nvim",
        event = { "UIEnter" },
    },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = true,
    },
    {
        "Vonr/align.nvim",
    },
}

M.editor = {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            { "windwp/nvim-ts-autotag" },
            { "JoosepAlviste/nvim-ts-context-commentstring" },
            { "nvim-lua/plenary.nvim" },
        },
        event = { "UIEnter" },
    },
    {
        "RRethy/vim-illuminate",
        event = { "UIEnter" },
    },
    {
        "numToStr/Comment.nvim",
        dependencies = {
            { "JoosepAlviste/nvim-ts-context-commentstring" },
        },
        event = { "VeryLazy" },
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = {
            "kevinhwang91/promise-async",
        },
        event = { "VeryLazy" },
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
    },
    {
        "shellRaining/hlchunk.nvim",
        event = { "UIEnter" },
    },
    {
        "shellRaining/nvim_md_HFfont",
    },
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
    --     -- this is no required but if you want indent blanklink line this is needed
    --     dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- },
    -- {
    --     "lukas-reineke/indent-blankline.nvim",
    --     event = { "UIEnter" },
    -- },
}

aid_lazy.entry(M)

return M
